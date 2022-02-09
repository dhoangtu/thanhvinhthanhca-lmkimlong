% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Luật Ngài Khai Sáng" }
  composer = \markup {
    \column {
      \line { "Tv. 118" }
      \line { "đoạn 22 (câu 169-176)"  }
    }
  }
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d16 g |
  g8. fs16 \tuplet 3/2 { a8 a b } |
  b4 r8 a16 g |
  g8. b16 \tuplet 3/2 { c8 c b } |
  a4 r8 c16 c |
  e8 c a d |
  fs,4 r8 e16 d |
  b'8 a fs a |
  g4 r8 \bar "||" \break
  
  g |
  g8. fs16 a8 a |
  b e,4 e8 |
  d8. a'16 c8 a |
  a b r g |
  c8. c16 a8 a |
  e' e4 e16 c |
  a8 d, fs16 (a) g8 |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d16 g |
  g8. fs16 \tuplet 3/2 { a8 a b } |
  b4 r8 a16 g |
  g8. g16 \tuplet 3/2 { a8 a g } |
  d4 r8 a'16 a |c8 a fs d |
  d4 r8 b16 b |
  g'8 c, d d |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lời con kêu nguyện vang lên tới Chúa,
  Xin luật Ngài khai sáng trí khôn con.
  Lời cầu khấn vang vọng tới Ngài,
  Như Ngài hứa, xin giải thoát con.
  <<
    {
      \set stanza = "1."
      Môi con trào dâng câu tán tụng,
      xin Ngài đem thánh chỉ dạy con,
      Miệng con ca mừng lời Chúa hứa,
      Huấn lệnh Ngài toàn hảo công minh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Trông mong Ngài ra tay đỡ đần,
	    con chọn theo huấn lệnh Ngài luôn,
	    Hồn con trông đợi Ngài cứu rỗi,
	    Thánh chỉ Ngài làm thỏa thuê con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin bang trợ con theo huấn lệnh,
	    cho hồn con sống mà tụng ca,
	    Dù như chim lạc đàn lỡ bước,
	    Phán định Ngài nguyện chẳng khi quên.
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
  page-count = #1
}

TongNhip = {
  \key g \major \time 2/4
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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
