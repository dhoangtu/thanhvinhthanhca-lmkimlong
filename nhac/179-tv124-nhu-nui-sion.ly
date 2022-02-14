% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Như Núi Si-on" }
  composer = "Tv. 124"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f8 f d c |
  a'4. a8 |
  f4 bf8 a |
  g2 |
  bf8 bf g g16 (bf) |
  c4. a8 |
  g4 c8 e, |
  f4 r8 \bar "||" \break
  
  g8 |
  a e4 f8 |
  d4. c8 |
  a'16 (bf) a8 g f |
  g4 r8 a |
  e f4 d8 |
  c4. c8 |
  a c g'16 (a) g8 |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 f d c |
  f4. fs8 |
  d4 g8 f |
  e2 |
  g8 g d f16 (g) |
  e4. f8 |
  bf,4 bf8 c |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ai tin cậy vào Chúa,
  khác nào núi Si -- on,
  không bao giờ chuyển lay,
  muôn đời vững bền luôn
  <<
    {
      \set stanza = "1."
      Như núi đồi bao bọc thành thánh Giê -- ru -- sa -- lem,
      Chúa chở che dân Ngài
      Bây giờ và đến muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin chớ để dân lành bị ác nhân cai trị luôn,
	    Lỡ bàn tay vô tội
	    Theo họ mà nhiễm gian tà.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin Chúa xử nhân hậu cùng kẻ khoan dung, thẳng ngay,
	    Lũ ngả theo gian tà
	    Xin đuổi sạch hết trên đời.
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
