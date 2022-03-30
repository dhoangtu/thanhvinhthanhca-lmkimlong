% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vào Thời Cánh Chung" }
  composer = "Is. 2,2-5"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  c8 c a' (g) |
  f8. g16 e8 e |
  a4. a16 g |
  f8 bf d g,16 (bf) |
  c4 r8 a16 g |
  a8 c e, ef |
  d4 r8 c16 f |
  e8 g a4 ~ |
  a8 c16 d bf8 g |
  f4 \bar "||" \break
  
  c8 a'16 (g) |
  f8. f16 e8 g |
  a a r a |
  g a bf8. a16 |
  bf8 c r f |
  f bf, c8. d16 |
  g,8 g r c, |
  g' bf a8. g16 |
  a8 f ~ f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*9
  r4
  c8 a'16 (g) |
  f8. d16 c8 e |
  f f r f |
  e f g8. f16 |
  g8 a r a |
  d g, a8. f16 |
  e8 e r c |
  bf d c8. bf16 |
  c8 a ~ a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Vào thời cánh chung núi đền thờ Chúa
      đứng kiêu hùng trên các đỉnh non,
      Vươn mình trên hết mọi ngọn đồi
      Ngàn dân cùng đi tới.
      Muôn nước đổ tuôn về.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Vì từ Si -- on thánh luật truyền xuống,
	    Chúa ban lời tự Giê --
	    \markup { \italic \underline "ru-sa" } -- lem,
	    Nay Ngài sẽ đứng làm trọng tài
	    Để phân xử muôn nước,
	    Minh xét mọi dân tộc.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Họ sẽ đúc gươm giáo thành cày cuốc,
	    mác đao rèn nên hái liềm luôn,
	    Dân này thôi chống lại dân nọ
	    Chẳng đâu còn vung kiếm
	    Hay thao luyện binh bị.
    }
  >>
  \set stanza = "ĐK:"
  Nào đến đây ta cùng lên Núi Chúa,
  lên đền Thiên Chúa nhà Gia -- cóp,
  Chúa sẽ dạy ta lối đường Ngài,
  để ta bước đi theo ý Ngài.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.7
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
