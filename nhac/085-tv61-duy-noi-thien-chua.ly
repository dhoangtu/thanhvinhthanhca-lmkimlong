% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Duy Nơi Thiên Chúa" }
  composer = "Tv. 61"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  e8 f16 (e) d8 d |
  e4. c8 |
  d d16 (c) a8 c |
  d4 d8 f |
  e e16 e a8 b |
  c4. a8 |
  b2 ~ |
  b4 b8. b16 |
  e8 e r a,16 a |
  a8 b c4 |
  r8 g16 g a8 b |
  e,4 c'8. c16 |
  c8 b16 (c) d8 d |
  e4. e8 |
  a,2 ~ |
  a4 \bar "||"
  
  a8 b |
  c (b) a8. g16 |
  a8 e4 c'8 |
  b2 ~ |
  b4 a8. a16 |
  e'8 e4 d16 (c) |
  b4 g8 a |
  e8. e16 b8 e16 (g) |
  a2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 f16 (e) d8 d |
  e4. c8 |
  d d16 (c) a8 c |
  d4 d8 f |
  e e16 d c8 e |
  a4. f8 |
  e2 ~ |
  e4 e8. e16 |
  c'8 c r f,16 f |
  f8 e a4 |
  r8 e16 e f8 d |
  e4 a8. a16 |
  a8 gs16 (a) b8 b |
  g4. g8 |
  a2 ~ |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Duy có nơi Thiên Chúa,
  hồn tôi mới được nghỉ ngơi.
  Vì nơi Ngài là nguồn ơn cứu rỗi của tôi.
  Ngài là Núi Đá, là thành trì kiên cố,
  là nguồn ơn tế độ
  nên tôi không mảy may nao núng khiếp sợ.
  <<
    {
      \set stanza = "1."
      Nhờ Thiên Chúa tôi được cứu độ hiển vinh,
      Ngài là núi đá vững vàng
      Ở nơi Ngài tôi hằng ẩn thân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đoàn dân hỡi mau cậy tin Ngài sắt son,
	    Thổ lộ với Chúa nỗi lòng
	    Và nương tựa nơi Ngài mà thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Thường dân cũng âu chỉ như làn khói bay,
	    Hạng quyền quí cũng ảo huyền,
	    Đặt cân thì hơn gì cụm mây.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đừng tin tưởng nơi trò bóc lột thế nhân,
	    Tiền tài tấn phát dẫu nhiều,
	    Đừng để lòng mê mẩn lắm chi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ngài luôn nắm uy quyền nhưng đầy nghĩa nhân,
	    Và này chính Chúa thưởng phạt
	    Tùy theo việc mỗi người thực thi.
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
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
