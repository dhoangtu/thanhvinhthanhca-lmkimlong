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
      d8 _> ~ |
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
  d ~ |
  d d bf a |
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
  e a d d |
  c4.
  <<
    {
      g8 _> ~ |
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
  \set stanza = "ĐK:"
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
