;; This is an operating system configuration generated
;; by the graphical installer.

;; editted by phossil

;; start block
;;(use-modules (gnu))
(use-modules (gnu) (nongnu packages linux)
             (nongnu system linux-initrd))
;; end block
(use-service-modules desktop networking ssh xorg)

(operating-system
;; start block
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
;; end block
  (locale "en_US.utf8")
  (timezone "America/Chicago")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "Geek-Box")
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
      (list (service xfce-desktop-service-type)
            (service openssh-service-type)
            (set-xorg-configuration
              (xorg-configuration
                (keyboard-layout keyboard-layout))))
      %desktop-services))
  (bootloader
    (bootloader-configuration
      (bootloader grub-bootloader)
      (target "/dev/sda")
      (keyboard-layout keyboard-layout)))
  (swap-devices
    (list (uuid "88a9f0fb-ae24-43af-b1d7-b948c0cce359")))
  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device
               (uuid "e287e820-9db9-4734-a3bd-ebe015a50ad3"
                     'ext4))
             (type "ext4"))
           %base-file-systems)))
