% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Chúng Con Kính Thờ" }
  composer = "1Sk. 29,10-13"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  b'4. g8 |
  b c c b |
  a4 \tuplet 3/2 { fs8 g b } |
  a4 r8 a16 a |
  e8 e4 g16 (a) |
  d,4 d8 g |
  fs16 (g) b8 a a |
  g4 r8 \bar "||" \break
  
  d |
  b'4. g8 |
  c4. a8 |
  d d \slashedGrace { b16 ( } a8) [d] |
  g,4 r8 g16 g |
  fs8 a a b |
  e,4. e16 fs |
  d8 b' a fs |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*7
  r4.
  d8 |
  g4. f!8 |
  e4. g8 |
  fs fs fs fs |
  g4 r8 e16 e |
  d8 d d d |
  cs4. cs16 d |
  b8 d c d |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa là Thiên Chúa Ít -- ra -- en,
      Tổ phụ chúng con,
      Xin dâng Ngài lời Chúc tụng
      từ muôn thuở đến muôn muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lạy Chúa quyền năng Chúa lớn lao thay,
	    Rực rỡ ánh quang,
	    Đây muôn sự là của Ngài,
	    toàn thể trời đất muôn muôn loài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Lạy Chúa quyền vương đế nắm trong tay,
	    Ngài thực tối cao,
	    Luôn siêu vượt cả muôn loài,
	    là bao nguồn phú vinh sang giầu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lạy Chúa quyền năng dũng mãnh trong tay,
	    Làm chủ chúng sinh
	    Muôn muôn vật nhờ ở Ngài mà thêm mạnh mẽ gia tăng dần.
    }
  >>
  \set stanza = "ĐK:"
  Giờ đây, lạy Chúa là Đấng chúng con kính thờ,
  Xin dâng Ngài muôn câu cảm tạ,
  Và ca mừng Thánh Danh hiển vinh.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
