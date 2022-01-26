% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Đức Giêsu Kitô Là Chúa"
  composer = "Pl. 2,6-11"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a16 (bf) a8 g g |
  g4. c8 |
  f, f4 g8 |
  a4. g16 g |
  a8 f f g |
  d4. d16 d |
  g8 e f (g) |
  a2 |
  g8. e16 c'8 c |
  b!a r f |
  f g4 e8 |
  d2 |
  d8. f16 a8 f |
  f g r g |
  e d4 g8 |
  \set Score.repeatCommands = #'((volta "1"))
  c,2 
  \set Score.repeatCommands = #'((volta #f) (volta "2") end-repeat)
  c4 r8 g'16 e
  \set Score.repeatCommands = #'((volta #f))
  a8 a a c |
  a g r g |
  e8. f16 f8 d |
  e c r c |
  c4 c8 c |
  a'4 r8 a16 bf |
  c8 c c d |
  c4 r8 g16 g |
  bf8 bf a g |
  f8. d'16 c8 c |
  c c4 c8 |
  \stemDown f2 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  R2*16
  r4. e16 c |
  f8 f f a |
  f e r bf |
  c8. d16 c8 b! |
  c c r c |
  c4 c8 c |
  f4 r8 f16 g |
  a8 a a bf |
  a4 r8 e16 e |
  g8 g f e |
  d8. bf'16 a8 a |
  a a4 <bf g>8 |
  <bf g>2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Đức Giê -- su Ki -- tô vốn thực là Thiên Chúa,
      Nhưng không nghĩ phải đòi cho được Địa Vị
      ngang hàng Thiên Chúa,
      Nhưng Người đã hóa ra không,
      mặc lấy thân nô lệ,
      Trở nên giống hết phàm nhân,
      sống như người thế trần.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Đức Giê -- su Ki -- tô đã hạ mình khiêm tốn,
	    Xin vâng đến chịu nhận tử hình,
	    Tử hình ô nhục thập giá.
	    Nên rầy Chúa đã siêu tôn và đã ban cho Người
	    được nhận lãnh một hiệu danh
	    cao vượt mọi danh - hiệu.
	    Nên vừa khi nghe danh thánh Giê -- su,
	    trên trời dưới đất cùng hỏa ngục,
	    Mọi loài đều quỳ gối,
	    Và để suy tôn Thiên Chúa Cha,
	    Mọi miệng lưỡi hãy tuyên xưng rằng:
	    Đức Giê -- su Ki -- tô là Chúa.
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
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
