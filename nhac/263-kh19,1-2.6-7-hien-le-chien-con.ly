% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Hiến Lễ Chiên Con"
  composer = "Kh. 19,1-2.6-7"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8 e |
  g (a) g4 |
  e'8 d c (b) |
  c2 ~ |
  c4 \bar "|." \break
  
  c8 g |
  e8. e16 a8 a |
  e4. c8 |
  e f4 d8 |
  g2 |
  g8. e16 e8 a |
  a4. g8 |
  c8 a4 c8 |
  d2 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  c8 e |
  g8 (a) g4 |
  c,8 [f] fs (g) |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  AL -- LE -- LU -- IA,
  AL -- LE -- LU -- IA.
  <<
    {
      \set stanza = "1."
      Chúa ta thờ là Đấng Cứu Độ đầy vinh hiển quyền uy,
      Bao lời Ngài phán quyết đều chân thật công minh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Hỡi ai là đầy tớ Chúa Trời,
	    nào ca hát Ngài đi.
	    Muôn người dù lớn bé hằng tôn sợ Thiên Chúa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa đương vị Hoàng đế thống trị
	    là Thiên Chúa toàn năng.
	    Mau hòa nhịp hân hoan mà dâng lời tôn vinh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Chính nay là ngày sẽ cử hành tiệc Hôn Lễ Chiên Con,
	    Trang phục kiều diễm quá:
	    HIền thê Người lộng lẫy.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 15\mm
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
