(defvar texture-packer-inputdir nil
  "Is the root directory containing the images")
(defvar texture-packer-outputdir nil
  "Is the output directory where the packed images will be placed")
(defvar texture-packer-packfilename nil
  "Is the name of the pack file and the prefix used for the output packed image files")
(defvar texture-packer-gdx-jar-path nil
  "Is the path where your gdx.jar file is located")
(defvar texture-packer-gdx-tools-jar-path nil
  "Is the path where your gdx-tools.jar file is located")

(defun texture-packer-pack ()
  "Run texture packer from the nightly build"
  (interactive)
    (call-process-shell-command
        (format "java -cp %s:%s com.badlogic.gdx.tools.texturepacker.TexturePacker %s %s %s"
            texture-packer-gdx-jar-path
            texture-packer-gdx-tools-jar-path
            texture-packer-inputdir
            texture-packer-outputdir
            texture-packer-packfilename)))

(provide 'init-libgdx)