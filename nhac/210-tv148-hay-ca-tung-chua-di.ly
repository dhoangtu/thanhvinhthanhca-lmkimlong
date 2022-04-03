% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Ca Tụng Chúa Đi" }
  composer = "Tv. 148"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 c8 ~ |
  c a'16 (g) f8 g |
  a4.
  <<
    {
      d8 ^> ~ |
      d c bf d |
      c4
    }
    {
      bf8 ~ |
      bf a g bf |
      a4
    }
  >>
  r8 \bar "" \break
  d, ~ |
  d d bf' a |
  g4.
  <<
    {
      a8 _> ~ |
      a g f a |
      g4
    }
    {
      f8 ~ |
      f e d f |
      c4
    }
  >>
  r8 \bar "" \break
  e ~ |
  e a d, d |
  c4.
  <<
    {
      g'8 _> ~ |
      g f e g |
      f2
    }
    {
      bf,8 ~ |
      bf a c bf |
      a2
    }
  >>
  \bar "||" \break
  
  <> \tweak extra-offset #'(-6 . -2.3) _\markup { \bold "ĐK:" }
  f'8. e16 a8 e |
  d4. c8 |
  g' g4 g8 |
  a4 r8 f |
  bf _> bf _> r bf |
  g c4 c8 |
  f,2 ~ |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c {
  r8 |
  R2*12
  f'8. e16 a8 e |
  d4. c8 |
  bf c4 c8 |
  f4 r8 ef |
  d d r g16 (f) |
  e8 e4 e8 |
  f2 ~ |
  f4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Từ cõi trời cao
      \tweak self-alignment-X #LEFT thẳm
      \override Lyrics.LyricText.font-series = #'bold
      Hãy ca tụng Chúa đi
      \revert Lyrics.LyricText.font-series
      Và tận cõi cao \tweak self-alignment-X #LEFT xanh
      \override Lyrics.LyricText.font-series = #'bold
      Hãy ca tụng Chúa đi
      \revert Lyrics.LyricText.font-series
      Mọi sứ thần của \tweak self-alignment-X #LEFT ngài
      \override Lyrics.LyricText.font-series = #'bold
      Hãy ca tụng Chúa đi
      \revert Lyrics.LyricText.font-series
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nào các đoàn binh Chúa
	    \repeat unfold 5 { _ }
	    Vầng nguyệt với kim ô
	    \repeat unfold 5 { _ }
	    Cùng tất cả sao trời
	    \repeat unfold 5 { _ }
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Nào cửu trung cao vút
	    \repeat unfold 5 { _ }
	    Và nguồn nước trên không
	    \repeat unfold 5 { _ }
	    Cùng hết mọi tạo thành
	    \repeat unfold 5 { _ }
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Từ khắp mười phương đất
	    \repeat unfold 5 { _ }
	    Nào thủy quái thâm cung
	    \repeat unfold 5 { _ }
	    Cùng tuyết lạnh, lửa hồng
	    \repeat unfold 5 { _ }
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Làn gió phục lệnh Chúa
	    \repeat unfold 5 { _ }
	    Trùng điệp núi non cao
	    \repeat unfold 5 { _ }
	    Và các loại thảo mộc
	    \repeat unfold 5 { _ }
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nào thú rừng gia súc
	    \repeat unfold 5 { _ }
	    Loài bò sát trăm muôn
	    \repeat unfold 5 { _ }
	    Cùng các loại chim trời
	    \repeat unfold 5 { _ }
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Nào khắp hàng vương đế
	    \repeat unfold 5 { _ }
	    Cùng thủ lãnh chư dân
	    \repeat unfold 5 { _ }
	    Và tất cả nhân trần
	    \repeat unfold 5 { _ }
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nào hết mọi trai tráng
	    \repeat unfold 5 { _ }
	    Này thục nữ đoan trang
	    \repeat unfold 5 { _ }
	    Phụ lão và nhi đồng
	    \repeat unfold 5 { _ }
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Ca tụng thánh danh Ngài thực quang vinh khôn sánh
  và oai phong cao vượt quá đất trời.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 0.5\mm
  bottom-margin = 0.5\mm
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
