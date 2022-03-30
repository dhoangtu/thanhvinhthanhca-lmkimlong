% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Muôn Dân Ca Ngợi" }
  composer = "Tv. 44,11-18"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 c |
  g4 g8 f |
  d8. (f16 g4 ~ |
  g) e16 (d) g8 |
  c,8. c16 e8 g |
  f2 ~ |
  f4 a8 a |
  f4. bf8 |
  bf g4 c8 |
  g4 f8 a |
  g4. e16 (d) |
  c8 g'4 g8 |
  f4 r8 \bar "||" \break
  
  a8 |
  a4 c8 a16 (g) |
  f4. g16 (f) |
  d4 f8 d |
  c4. c8 |
  g' a4 g8 |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*11
  r4.
  
  f8 |
  f4 e8 f16 (e) |
  d4. c8 |
  bf4 d8 bf |
  a4. a8 |
  bf c4 c8 |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin hãy nghe thưa nương tử,
      Đưa mắt nhìn và hãy lắng tai,
      Quên dân tộc, quên đi nhà thân phụ,
      Vì Đức Vua nay sủng ái sắc hương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tôn nữ đây bao diễm lệ
	    Xiêm áo nàng rực rỡ gấm hoa,
	    Trong huy hoàng tiến dẫn về thánh thượng
	    Đoàn nữ trinh vui mừng tiến bước theo.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin tiến lên trong hoan hỉ,
	    Bao diễm lệ vào tận chính cung.
	    Đây con Ngài sẽ nối dòng vương phụ,
	    Ngài tấn phong công thần khắp thế gian.
    }
  >>
  \set stanza = "ĐK:"
  Muôn dân sẽ nức lòng ca ngợi,
  Tiếng ca ngợi rền vang mãi muôn đời.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
