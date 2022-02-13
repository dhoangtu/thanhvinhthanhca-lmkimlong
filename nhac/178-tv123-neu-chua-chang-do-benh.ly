% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nếu Chúa Chẳng Đỡ Bênh" }
  composer = "Tv. 123"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 b8 |
  b8. g16 c8 b |
  a4. a8 |
  fs fs a e |
  d4 r8 b' |
  b8. g16 c8 b |
  a4 r8 a16 a |
  g8 g c cs |
  d4. d8 |
  a8 a c c |
  b4. a16 a |
  fs8 d a' a |
  g4 r8 \bar "||" \break
  
  e16 (fs) |
  d8. b'16 b8 d |
  b a4 c8 |
  c8. c16 b8 a |
  d fs,4 fs8 |
  a d, g a |
  b4. a8 |
  d c a fs |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 |
  g8. e16 a8 g |
  d4. cs8 |
  d d cs cs |
  d4 r8 g |
  g8. e16 a8 g |
  fs4 r8 fs16 fs |
  e8 e a g |
  fs4. fs8 |
  fs fs a a |
  g4. d16 d |
  c8 b c d |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Nếu Chúa chẳng đỡ bênh ta,
  Ít -- ra -- en nói lên nào,
  Nếu Chúa chẳng đỡ bênh ta,
  Khi thiên hạ nhằm ta xông tới,
  chắc là họ nuốt sống ta
  trong cơn giận bừng sôi căm hờn.
  <<
    {
      \set stanza = "1."
      Hẳn là nước đã cuốn ta đi,
      thác lũ đã dâng lên lút đầu,
      Dòng nước cuồn cuộn chảy xiết
      Vùi lấp cả sinh mạng ta.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Cất lời tung hô Chúa ta đi,
	    Đấng đã chẳng khi nào phó mặc
	    Để chúng lại giơ nanh vuốt
	    Vồ lấy ta như mồi ngon.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ví tựa chim bay thoát bẫy giăng,
	    lưới đứt khiến ta rầy thoát nạn,
	    Được cứu độ nhờ danh Chúa
	    là Đấng tác tạo càn khôn.
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
  \key g \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.8
    \override LyricHyphen.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
