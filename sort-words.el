;;; sort-words.el --- Sort words in a selected region

;; Filename: sort-words.el
;; Description: Sort words in a selected region
;; Author: "Aleksandar Simic" <asimic@gmail.com>
;; License: BSD
;; Created: 2016-09-07
;; Version: 0.0.1
;; Homepage: http://github.org/dotemacs/sort-words.el
;; Keywords: tools

;;; Commentary:
;;
;; Usage: select a region and then
;; M-x sort-words RET

;;; This file is NOT part of GNU Emacs
;;
;; Copyright (c) 2016, Aleksandar Simic
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;; 2. Redistributions in binary form must reproduce the above
;;    copyright notice, this list of conditions and the following
;;    disclaimer in the documentation and/or other materials provided
;;    with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
;; FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;; COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
;; INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;; OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Code:

(defun sort-words-list-to-string (lst)
  "convert a given list LST to a string, joined with spaces"
  (mapconcat 'identity lst " "))

(defun sort-words-in-region (start end)
  "sorts the words in a given region and returns them as a list"
   (sort (split-string (buffer-substring-no-properties start end)) #'string<))

;;;###autoload
(defun sort-words (start end)
  "Select a region, sort words within it
   and insert them replacing the existing region"
  (interactive "r")
  (if (use-region-p)
      (save-excursion
        (save-restriction
          (narrow-to-region start end)
          (let ((words (sort-words-list-to-string (sort-words-in-region (point-min) (point-max)))))
            (delete-region (point-min) (point-max))
            (goto-char (point-min))
            (insert words))))
    (message "no region has been selected")))

(provide 'sort-words)

;;; sort-words.el ends here
