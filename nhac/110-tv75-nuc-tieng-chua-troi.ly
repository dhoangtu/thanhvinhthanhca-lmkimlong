% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nức Tiếng Chúa Trời" }
  composer = "Tv. 75"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 c16 f |
  f4 \tuplet 3/2 { g8 g g } |
  e4 \tuplet 3/2 { d8 bf' a } |
  g4 \tuplet 3/2 { g8 f g } |
  \slashedGrace { g16 ( } c2) ~ |
  c8 bf ^> bf ^> bf ^> |
  g4. g16 a |
  a4 r8 bf16 a |
  g4 \tuplet 3/2 { c,8 g' a } |
  f2 ~ |
  f4 r8 \bar "|."
  
  f |
  f8. d16 \tuplet 3/2 { f8 bf a } |
  g4 \tuplet 3/2 { g8 g g } |
  c,4. e16 f |
  \slashedGrace { a16 ( } g2) ~ |
  g4
  <<
    {
      \voiceOne
      g8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1
      \parenthesize
      f8
    }
  >>
  f |
  g8. bf16 d (c) bf8 |
  c4 \tuplet 3/2 { a8 c bf } |
  \slashedGrace { bf16 _( } a8.) g16 c,8 e |
  \slashedGrace { g16 _( } f2) ~ |
  f4 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*19
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Miền Giu -- đa nức tiếng Chúa Trời,
  Tại Is -- ra -- el danh Ngài cao cả:
  Chúa đã cắm lều tại Sa -- lem,
  Núi Si -- on là nơi Chúa ngự.
  <<
    {
      \set stanza = "1."
      Nơi đây Ngài bẻ gẫy cung tên,
      gươm đao khiên mộc, mọi vũ khí.
      \markup { \italic \underline "Ngài" }
      thực là rực rỡ hùng oai
      Vì chiến lợi phẩm thu về từng núi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao nhiêu ngựa xe đứng chôn chân,
	    bao tay anh hùng đều rời rã,
	    Khi Ngài vừa giận dữ thị uy
	    Vì trước Thiên Nhan ai người đứng vững?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Dương gian rầy kinh hãi im hơi,
	    khi trên cung trời Ngài tuyên án,
	    \markup { \italic \underline "Ngài" }
	    vùng dậy xử xét trần gian
	    Để cứu nguy cho bao người nghèo khó.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nhân gian cùng lên tiếng tri ân,
	    qua cơn lôi đình, được vui sướng.
	    Mau nguyện cầu, dâng lễ tạ ơn,
	    Ngài khiến quân vương gian trần kinh hãi.
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
}

TongNhip = {
  \key f \major \time 2/4
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
