% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Như Em Thơ" }
  composer = "Tv. 130"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e8 |
  a4 \tuplet 3/2 { a8 b a } |
  gs4. e16 c' |
  b4 \tuplet 3/2 { b8 c b } |
  a4 r8 a16 c |
  b4 \tuplet 3/2 { d8 d d } |
  e4 r8 e,16 c' |
  b8. b16 \tuplet 3/2 { b8 c b } |
  a4 r8 \bar "||" \break
  
  e |
  g8. g16 \tuplet 3/2 { g8 g gs } |
  a4 \tuplet 3/2 { d,8 f e } |
  e4 r8 b'16 b |
  b4. a16 (b) |
  gs8. e16 \tuplet 3/2 { c'8 b a } |
  a4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lòng con đâu dám tự hào,
  và mắt con đâu dám trông cao,
  Đường danh vọng con không đưa bước,
  Việc lớn lao con đâu dám mưu cầu.
  <<
    {
      \set stanza = "1."
      Hồn con, con ru êm dỗ nín lặng lẽ trong con
      Như em thơ nép mình ngủ kỹ trong lòng mẹ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Thành tâm tin yêu nơi Thiên Chúa,
	    này Ít -- ra -- en,
	    Ngay khi nay, vững bền ngàn kiếp qua ngàn đời.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
