;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "Geek-3350")
  (users (cons* (user-account
                  (name "phossil")
                  (comment "Phosu Parsons")
                  (group "users")
                  (home-directory "/home/phossil")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages
    (append
      (list (specification->package "nss-certs"))
      %base-packages))
  (services
    (append
      (list (service gnome-desktop-service-type)
            (service enlightenment-desktop-service-type)
            (set-xorg-configuration
              (xorg-configuration
                (keyboard-layout keyboard-layout))))
      %desktop-services))
  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (target "/boot/efi")
      (keyboard-layout keyboard-layout)))
  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device
               (uuid "3c163746-0609-4a76-8a79-56ae2c4efe3e"
                     'btrfs))
             (type "btrfs"))
           (file-system
             (mount-point "/boot/efi")
             (device (uuid "7C0B-F89C" 'fat32))
             (type "vfat"))
           %base-file-systems)))
