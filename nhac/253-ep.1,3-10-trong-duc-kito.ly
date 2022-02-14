% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Trong Đức Kitô" }
  composer = "Ep. 1,3-10"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g8 |
  c,4. d8 |
  e4 e8 d |
  a' g g g |
  g4 c8 c |
  b2 ~ |
  b8 b c b |
  a4 a8 b |
  g8. g16 e'8 e |
  e16 (f) e8 d4 |
  d8. d16
  \afterGrace a8 ({
    \override Flag.stroke-style = #"grace"
    c16)}
  \revert Flag.stroke-style
  a8 |
  g8. b16 d8 d |
  c2 \bar "|."
  
  e,4 f8 e |
  d4 d8 d |
  g4. a8 |
  f8 e d g |
  c,2 ~ |
  c4 r8 c |
  f4 f8 e |
  d4. d16 c |
  g'8 g e a |
  f4 d8 d |
  g4. g8 |
  c,4 r8 \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  g8 |
  c,4. d8 |
  e4 e8 d |
  a' g f f |
  e4 e8 e |
  g2 ~ |
  g8 g a e |
  f4 f8 g |
  e8. c16 c'8 c |
  c16 (d) c8 g4 |
  fs8. fs16 f!8 [f] |
  e8. d16 f8 f |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Chúc tụng Thiên Chúa, Thân Phụ Đức Giê -- su Ki -- tô,
  Chúa chúng ta,
  Trong Đức Ki -- tô, tự cõi trời Ngài đã giáng phúc thi ân
  Cho ta hưởng muôn vàn ân phúc Thánh Linh.
  <<
    {
      \set stanza = "1."
      Trong Đức Ki -- to, Ngài chọn ta
      trước khi tạo thành vũ trụ.
      Để trước thánh nhan Ngài
      ta trở nên tinh tuyền thánh thiện
      nhờ tình thương của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Theo Chúa tiên định,
	    vì tình thương đã cho ta làm nghĩa tử,
	    Nhờ chính Đức Ki -- tô,
	    ta ngợi khen ân sủng rạng ngời
	    mà Ngài cho lãnh nhận.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Do máu con Ngài đã đổ ra,
	    chúng ta nay được cứu độ,
	    Được miễn thứ tội tình
	    theo hồng ân khôn lường của Ngài
	    rầy tặng ta dẫy đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Do ý nhiệm mầu mà rầy ta thấu tỏ
	    chương trình của Ngài,
	    Từ trước đã an bài
	    theo sự khôn ngoan lịch lãm Ngài,
	    vì tình thương ấn định.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Trong Đức Ki -- tô Ngài gộp thâu
	    tất cả vạn vật đất trời,
	    Là lúc Chúa an bài
	    Cho thời gian viên thành mãn hồi,
	    Ngài thực thi ý định.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  page-count = 1
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
