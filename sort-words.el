
(defun list-to-string (lst)
  "convert a given list LST to a string, joined with spaces"
  (mapconcat 'identity lst " "))

(defun sort-words-in-region (start end)
  "sorts the words in a given region and returns them as a list"
   (sort (split-string (buffer-substring-no-properties start end)) #'string<))

(defun sort-words (start end)
  "Select a region, sort words within it
   and insert them replacing the existing region"
  (interactive "r")
  (if (use-region-p)
      (save-excursion
        (save-restriction
          (narrow-to-region start end)
          (let ((words (list-to-string (sort-words-in-region (point-min) (point-max)))))
            (delete-region (point-min) (point-max))
            (goto-char (point-min))
            (insert words))))
    (message "no region has been selected")))
