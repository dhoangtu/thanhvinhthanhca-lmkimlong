% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Con Kêu Tới Chúa"
  composer = "Tv. 119"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f16 f |
  e8. g16 g8 a |
  d,4. d8 |
  bf'4. g16 g |
  a2 |
  d4. e16 cs |
  d8. d16 \tuplet 3/2 { bf8 g a } |
  a8. f16 \tuplet 3/2 { a8 a e } |
  d2 \bar "||"
  
  f8. f16 e8 d |
  g g r g |
  g8. g16 e8 g |
  f f r d'16 c |
  bf8 a g bf |
  a4 r8 g16 a |
  f8 g a e |
  d4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f16 f |
  e8. g16 g8 a |
  d,4. d8 |
  g4. e16 e |
  f2 |
  bf4. g16 a |
  f8. f16 \tuplet 3/2 { g8 e f } |
  f8. d16 \tuplet 3/2 { cs8 cs cs } |
  d2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Khi lâm nạn con kêu tới Ngài,
  Ngài đã nhậm lời con.
  Xin cứu mạng con thoát môi miệng điêu ngoa,
  khỏi tấc lưỡi phỉnh phờ.
  <<
    {
      \set stanza = "1."
      Tấc lưỡi phỉnh phờ kia ơi,
      Chúa sẽ giáng gì xuống ngươi đây,
      Giáng tên nhọn của người chiến binh,
      thêm những hòn than đuốc đỏ hồng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Khổn đốn cho phận tôi đây
	    Sống giữa lũ người ở Kê -- đa,
	    Chúng luôn muốn gây chuyện chiến chinh,
	    trong lúc lòng tôi muốn an bình.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 15\mm
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
