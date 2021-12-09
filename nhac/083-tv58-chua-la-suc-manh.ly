% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Chúa Là Sức Mạnh"
  composer = "Tv. 58"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8. g16 a (g) e8 |
  f4. f16 g |
  e8 d g e16 (d) |
  c4 r8 e16 f |
  d8 e16 (d) c8 c |
  a'4. a16 a |
  f8 d b d |
  c4 r8 \bar "||"
  
  g'8 |
  c,8. f16 d8 d |
  g4 r8 g |
  f8. a16 g8 e |
  d2 |
  r8 c c c |
  f8. (g16) d8 d |
  g4 r8 g |
  e'8. e16 d8 b |
  c2 ~ |
  c4 r \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*7
  r4.
  g8 |
  c,8. f16 d8 d |
  g4 r8 e |
  d8. f16 e8 c |
  b2 |
  r8 c c c |
  f8. (g16) d8 d |
  g4 r8 g |
  c8. c16 f,8 g |
  e2 ~ |
  e4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Ôi Thiên Chúa của con
      xin cứu con khỏi lũ quân thù,
      Bênh đỡ con chống phường tàn ác,
      Cứu vớt con khỏi bạn sát nhân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Con đâu có tội chi
	    sao chúng toa rập quyết tiêu diệt,
	    Xin Chúa thương chỗi dậy trợ giúp,
	    Xét đoán con đâu lầm lỗi chi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ôi Thiên Chúa càn khôn
	    xin đứng lên trị lũ vô nghì,
	    Xin chớ dung túng bọn phản phúc,
	    Chúa Ích -- diên tiêu diệt chúng đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Con trông tới Ngài liên,
	    ôi sức thiêng, thành lũy bao bọc,
	    Canh giữ con bởi lòng trìu mến,
	    Tiếp giúp con nghênh bọn quân thù.
    }
  >>
  \set stanza = "ĐK:"
  Chúa là sức mạnh của con,
  xin dạo phím tơ ca mừng.
  Ngài là thành lũy bảo về con
  Lạy Đấng chứa chan tình thương.
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
