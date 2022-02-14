% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Chúa Trở Lại" }
  composer = "Tv. 59"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a8 |
  d4. g,16 g |
  a8 d, d16 (f) a8 |
  g4 r8 f16 f |
  g8 g a f |
  e4 r8 a |
  d4. g,16 g |
  a8 d, d16 (f) a8 |
  g4 r8 g16 g |
  f8 e a e |
  d2 \bar "||"
  
  d8. f16 e8 e ~ |
  e e16 e g8 a |
  d,2 |
  f8. f16 e8 a ~ |
  a g16 (f) d8 f |
  g4 bf8 bf |
  g g16 g d'8 bf |
  a4 a8 a |
  g8. f16 e8 a |
  d,2 ~ |
  d4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lạy Chúa, Ngài từng đã ruồng bỏ chúng con,
  Và làm cho tan nát tơi bời,
  Ngài đã từng nổi cơn thịnh nộ chúng con,
  Nay xin trở lại với dân Ngài.
  <<
    {
      \set stanza = "1."
      Ngài rung địa cầu và làm cho nứt rạn
      Nay xin hàn gắn cho khỏi lung lay
      Con dân Ngài, Ngài để nếm chua cay,
      Ép chúng con phải cạn chén nồng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài nâng hiệu kỳ để những ai kính sợ
	    Mau chân chạy trốn khỏi làn tên bay,
	    Xin nghe lời mà giải cứu chúng con,
	    Các chính nhân sẽ được thoát nạn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Từ trong điện thờ Ngài hiển linh phán truyền
	    Đây ta mừng rỡ chia sẻ Si -- khem,
	    Ai đo đạc đồng bằng Ép -- ra -- im,
	    Cất tiếng ca khải hoàn thắng trận.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai đâu dìu dắt lên tận Ê -- đom,
	    Chính Chúa đà từng ruồng rẫy chúng con,
	    Cũng đã không dẫn đường xuất trận.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ngài thương trợ lực để đoàn con thắng trận
	    Nhân gian phù giúp cũng chỉ bằng không,
	    Nay do Ngài được hùng dũng ra tay
	    Giúp chúng con tiêu diệt kẻ thù.
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
