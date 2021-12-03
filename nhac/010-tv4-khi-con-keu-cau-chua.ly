% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Khi Con Kêu Cầu Chúa"
  composer = "Tv. 4"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4. a8 a a |
  e8. c'16 c8 c |
  b2 ~ |
  b8 c b b |
  a8. d16
  \afterGrace c8 ({
    \override Flag.stroke-style = #"grace"
    d16)}
  \revert Flag.stroke-style
  e8 |
  e2 ~ |
  e4 r8 e, |
  c'4. a8 |
  a a4 c8 |
  b4 r8 b |
  d c4 e,8 |
  b' c4 b8 |
  a2 \bar "||" 
  
  g!?4. g8 |
  a4 \tuplet 3/2 { g8 a g } |
  e8. c16 c8 d |
  e2 ~ |
  e4 r8 e |
  b' c4 a16 b |
  b4 b |
  d8 e4 e16 (d) |
  e2 ~ |
  e8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 a a |
  e8. a16 a8 a |
  e2 ~ |
  e8 a g!? g |
  f8. f16 a8 [a] |
  gs2 ~ |
  gs4 r8 e |
  a4. f8 |
  f f4 a8 |
  e4 r8 e |
  f e4 e8 |
  d e4 d8 |
  c2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Khi con kêu cầu, Chúa đáp tiếng con,
  Lúc con cơ cùng, xin mở lối thoát.
  Lạy Chúa, là đền trời xét soi,
  nguyện đoái thương và nghe tiếng con cầu.
  <<
    {
      \set stanza = "1."
      Này phàm nhân, cho đến bao giờ lòng còn chai đá,
      còn ưa thích chuyện hư không,
      chạy theo điều giả dối.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Này hồn tôi chứa chan ân lộc kỳ diệu của Chúa
	    Lời tôi mới vừa kêu lên,
	    Ngài mau lẹ trả đáp.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Này người ơi, hãy mau run sợ,
	    đừng phạm tội nữa,
	    nằm yên đó, hôi tâm đi,
	    và tin cậy ở Chúa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Người người than: ai sẽ ban tặng một đời hạnh phúc?
	    phần con những chỉ trông mong Thần Nhan Ngài tỏa sáng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Lòng mừng vui hơn lúc thiên hạ được mùa lúa mới,
	    Nhờ ơn Chúa, được an tâm, này con nằm ngủ thiếp.
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
  \key c \major \time 2/4
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
