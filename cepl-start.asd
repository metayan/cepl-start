(asdf:defsystem #:cepl-start
  :description "Simple CEPL project to start with"
  :author "Yan Gajdoš <metayan@metatem.net>"
  :license "BSD 2 Clause"
  :serial t
  :depends-on (#:cepl.sdl2 #:livesupport
               #:rtg-math #:rtg-math.vari)
  :components ((:file "package")
               (:file "helpers")
               (:file "main")))
