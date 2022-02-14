% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hát Lên Mừng Chúa" }
  composer = "Tv.95"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4. c8 a f |
  bf8. g16 g8 bf |
  c4. d16 d |
  bf8 a g4 ~ |
  g8 g16 g e8 c |
  a'8 bf16 bf a8 g |
  c8. c16 e,8 g |
  f2 ~ |
  f4 r8 \bar "||"
  
  e |
  e8. e16 e8 g |
  a d, r c |
  d8. f16 a8 c |
  a g4 g16 bf |
  c8 c a16 (g) f8 |
  g8. g16 e (d) c8 |
  f2 ~ |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  c8 a f |
  d8. e16 e8 g |
  a4. bf16 bf |
  g8 f c4 ~ |
  c8 b!16 b c8 c |
  f g16 g f8 f |
  e8. d16 c8 bf |
  a2 ~ |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hát lên mừng Chúa một bài ca mới,
  hỡi tất cả địa cầu.
  Hãy hát lên mừng Chúa,
  hãy hát lên mừng Chúa,
  chúc tụng Thánh Danh.
  <<
    {
      \set stanza = "1."
      Ngày ngày tường thuật ơn cứu độ,
      Truyền tụng hiển vinh Chúa nơi nơi,
      Để muôn nước biết những kỳ công Chúa đã làm nên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Vì Ngài trọng đại đáng chúc tụng,
	    Trổi vượt thần thánh khắp chư dân,
	    Ngài uy dũng sáng tạo càn khôn,
	    lẫm liệt quyền năng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Trần hoàn nào cùng dâng tiến Ngài
	    Quyền lực uy dũng xứng Tôn Danh,
	    Cùng của lễ tiến lên hiệp dâng kính tôn Ngài đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Phục lạy Ngài quyền uy thánh thiện,
	    Toàn cầu kinh hãi trước Thiên Nhan,
	    Và công bố khắp trên trần gian Chúa đây là Vua.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Người lập địa cầu không chuyển rời,
	    Xử trị muôn nước cách công minh,
	    Trời vui lên, đất nhảy mừng đi,
	    biển khơi gầm vang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ruộng đồng cùng rừng xanh hát mừng,
	    Này Người ngự đến giữa uy linh,
	    Dùng công lý xét xử trần gian,
	    hết thảy mọi dân.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 1.5))
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
    \override Lyrics.LyricSpace.minimum-distance = #0.7
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
