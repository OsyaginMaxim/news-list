//
//  Player.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import Foundation
import AVFoundation
import MediaPlayer

protocol PlayerServiceProtocol: AnyObject {
    func currentTimeChanged(time: CMTime)
    func getDuration(duration: Double)
    func newPodcast(podcast: MediaModel, episodeId: Int)
    func changeStatus(isPlaying: Bool)
}

class Player: NSObject {
    weak var delegate: PlayerServiceProtocol?

    var player = AVPlayer()

    var timeObserverToken: Any?

    private var media: MediaModel?

    private var status: AVPlayer.TimeControlStatus = .waitingToPlayAtSpecifiedRate {
        didSet {
            delegate?.changeStatus(isPlaying: isPaying())
        }
    }

    override init() {
        super.init()

        setupAudioSession()
    }

    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            if #available(iOS 11.0, *) {
                try audioSession.setCategory(.playback, mode: .default, policy: .longForm)
            } else {
                try audioSession.setCategory(.playback, mode: .default, options: [])
            }
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(handleInterruption),
            name: AVAudioSession.interruptionNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(handleRouteChange),
            name: AVAudioSession.routeChangeNotification,
            object: nil
        )
    }

    func play(with media: MediaModel, episodeId: Int) {
        guard
            let url = URL(string: media.url ?? "")
        else { return }

        if status == .playing {
            pause()
        }

        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
        player.play()

        self.media = media

//        delegate?.newPodcast(podcast: podcast, episodeId: episodeId)

        addPeriodicTimeObserver()
    }

//    func getPodcast() -> (PodcastModelDTO?, EpisodModelDTO?) {
//        let episode = podcast?.episode(with: episodeId ?? 0)
//        return (podcast, episode)
//    }

    private func addPeriodicTimeObserver() {
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 1.0, preferredTimescale: timeScale)

        timeObserverToken = player.addPeriodicTimeObserver(
            forInterval: time,
            queue: .main
        ) { [weak self] time in
            guard let self = self else { return }
            if
                self.player.status == .readyToPlay,
                let duration = self.player.currentItem?.duration.seconds
            {
                self.delegate?.getDuration(duration: duration)
            }
            if self.status != self.player.timeControlStatus {
                self.status = self.player.timeControlStatus
            }

            if self.status == .playing {
                self.delegate?.currentTimeChanged(time: time)
            }
        }
    }

    private func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }

    @objc func handleInterruption(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue)
        else {
            return
        }

        if type == .began {
            pause()
        } else if type == .ended {
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)

            if options.contains(.shouldResume) {
                play()
            }
        }
    }

    @objc func handleRouteChange(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue)
        else {
            return
        }

        if reason == .oldDeviceUnavailable {
            pause()
        }
    }
}

extension Player {
    func play() {
        if player.status == .readyToPlay {
            switch status {
            case .paused:
                player.play()
                addPeriodicTimeObserver()
            default: break
            }
        }
    }

    func pause() {
        switch status {
        case .playing:
            player.pause()
            removePeriodicTimeObserver()
        default: break
        }
    }

    func isPaying() -> Bool {
        return status == .playing
    }
}
