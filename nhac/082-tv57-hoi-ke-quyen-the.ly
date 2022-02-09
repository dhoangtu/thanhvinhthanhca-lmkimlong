% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hỡi Kẻ Quyền Thế" }
  composer = "Tv. 57"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  e8. e16 c8 c |
  f4 \tuplet 3/2 { f8 d a' } |
  g8. a16 f8 e |
  d4 \tuplet 3/2 { d8 e e } |
  d8. c16 c8 a' |
  a4 r8 f16 f |
  g8. g16 d8 e |
  c4 r8 \bar "||"
  
  c'8 |
  b4 \tuplet 3/2 { e,8 e e } |
  a4. a16 a |
  g4 r8 f |
  f4 \tuplet 3/2 { d8 d d } |
  g4. \slashedGrace { a16 _( } g8) |
  c,2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*7
  r4.
  e8 |
  d4 \tuplet 3/2 { d8 c d } |
  c4. f16 f |
  e4 r8 d |
  d4 \tuplet 3/2 { c8 c c } |
  b4. b8 |
  c2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Hỡi những kẻ quyền thế
      có thực các ngươi xét xử công bình,
      hay những rắp tâm làm điều bất chính
      Và mạnh tay tung hoành ác tan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Những lũ người độc ác đã lạc hướng
	    khi mới lọt lòng mẹ,
	    ngay lúc mới sinh lầm đường lỡ bước
	    Nọc họ phu khác nào rắn độc.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa hãy trừng trị chúng
	    khiến vụt biến như nước chảy qua cầu,
	    mau nát bấy như ngọn cỏ bốc cháy,
	    Tựa loài sên đang bò rữa dần.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Thấy thế người người nói:
	    Có phần phúc cho những kẻ ngay lành,
	    Thiên Chúa vẫn luôn điều hành thế giới,
	    Bọn tàn ác sẽ bị báo thù.
    }
  >>
  \set stanza = "ĐK:"
  Ước chi lửa giận của Chúa cuốn chúng đi,
  Mau như lửa rực bụi gai bén mồi.
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
