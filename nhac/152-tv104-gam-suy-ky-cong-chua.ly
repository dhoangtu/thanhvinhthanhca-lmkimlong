% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Gẫm Suy Kỳ Công Chúa" }
  composer = "Tv. 104"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  b8. b16 g8 c ~ |
  c a16 a e'8 d |
  b2 |
  fs8. g16 e8 d ~ |
  \once \override NoteColumn.X-offset = -1 d
  b'16 g c8 b |
  a4 r8 e' |
  c ^> c ^> r d |
  b8. a16 g8 a |
  a b4 e,8 |
  g8. b16 a8 fs16 (e) |
  d8 a'4 a16 (b) |
  g2 \bar "||"
  
  a4. fs16 (e) |
  d8 d a' a |
  b4 r8 b16 g |
  c8 a e' (d) |
  b8. d,16 b'8 g |
  a2 |
  b4. e,8 |
  e e a a |
  d,4 r8 e |
  c'4. c16 b |
  a8 a d fs, |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8. g16 f!8 e ~ |
  e e16 e c'8 a |
  g2 |
  d8. e16 cs8 d ~ |
  d d16 e a8 g |
  fs4 r8 c' |
  a a r b |
  g8. fs16 e8 e |
  d g4 c,8 |
  e8. d16 c8 [c] |
  b c4 d8 |
  b2
  R2*12
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Hãy cảm tạ Chúa và cầu khấn danh Ngài,
  Kỳ công của Ngài loan truyền giữa muôn dân.
  Hát lên đi, tấu vang cung đàn ca khen Chúa,
  Và hãy gẫm suy những kỳ công của Ngài.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Hãy tự hào vì Uy Danh Chúa,
      Tâm hồn những ai kiếm Ngài nào hãy mừng vui.
      Hãy tìm Ngài cùng với sức mạnh
      Và quyết chẳng khi ngừng tìm kiếm Thần Nhan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hãy nhớ lại kỳ công tay Chúa,
	    Dấu lạ Chúa làm với bao nghị quyết Ngài ban,
	    Hết mọi điều Ngài đã phán định
	    Là chính giới răn chung cho khắp trần gian.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa đã từng lập ra giao ước,
	    Bao lời hứa Ngài nhớ luôn và đã thực thi.
	    Đó là điều Ngài đã ước thề:
	    Dòng dõi Áp -- ra -- ham đây Chúa chọn riêng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Với bao là quyền uy tay Chúa,
	    Đã làm muôn vàn dấu lạ cùng với điềm thiêng
	    Dẫn dòng tộc Ngài đã kén chọn
	    Vào đất hứa ban tặng tiền bối thuở xưa.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key g \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
