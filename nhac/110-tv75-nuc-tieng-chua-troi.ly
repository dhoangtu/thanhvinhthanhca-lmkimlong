% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Nức Tiếng Chúa Trời"
  composer = "Tv. 75"
  %arranger = "Lm. Kim Long"
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
  f4 r8 \bar "||"
  
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
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*19
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
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
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %page-count = #1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

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

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
