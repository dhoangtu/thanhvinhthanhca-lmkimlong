% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Sẽ Tạ Ơn Suốt Đời" }
  composer = "Tv. 51"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f8 g e f |
  d4. e8 |
  c4 r8 c |
  a'4 f8 f |
  bf4 a |
  g2 ~ |
  g4 r8 a |
  f g e f |
  d4. c8 |
  a'4 a8 a |
  f4 a |
  bf4. g8 |
  bf c4 g8 |
  f2 \bar "||"
  
  f8 e f a |
  d,4. c8 |
  a' a16 a bf8 a |
  g4. g8 |
  g2 bf8 a bf d |
  g,4. e8 |
  f e16 d c8 c |
  g'4. g8 |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 g e f |
  d4. e8 |
  c4 r8 c |
  f4 d8 d |
  g4 f |
  c2 ~ |
  c4 r8 cs |
  d b! c a |
  bf4. a8 |
  f'4 f8 f |
  d4 f |
  g4. e8 |
  g f4 e8 |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Con sẽ tạ ơn Chúa suốt đời,
  lạy Chúa, vì Ngài đã ra tay
  trước mặt những người hiếu trung của Chúa.
  Con trông cậy danh Chúa
  vì danh Chúa thiện toàn.
  <<
    {
      \set stanza = "1."
      Nương mình trong thánh điện
      hồn con đây như nhánh ô -- liu xanh tươi,
      Nơi tình thương của Ngài con sẽ luôn trông cậy
      thành tâm muôn đời
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Khoe tội ngươi ác độc,
	    ngày đêm luôn toan tính mưu gian khôn ngơi,
	    Môi tựa dao bén nhọn,
	    đây Cháu sẽ tiêu diệt mạng ngươi muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Trông cậy nơi đống tiền và khoe khoang
	    mưu chước ngươi bao thâm sâu.
	    Không tựa nương Chúa Trời
	    nên Chúa bứng ngươi liệng khỏi nơi dương trần.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
