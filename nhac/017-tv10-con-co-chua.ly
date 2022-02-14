% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Còn Có Chúa" }
  composer = "Tv. 10"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  ef4 c8 c |
  d4 r8 a'16 bf |
  g8 a d, g |
  c4. ef8 |
  d4 c8 c |
  bf (d) c16 (bf) f8 |
  g2 ~ |
  g8 f!? g g |
  d8. ef16 c8 d |
  g4 r8 g16 g |
  f8 g ef d |
  d4 r8 g16 d |
  bf'8 a g bf |
  a4. a16 c |
  d8. fs,16 fs8 d |
  g4 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key g \major
  b8. a16 |
  c8 c b16 (a) d8 |
  g,4. g8 |
  e8. d16 b'8 g |
  a2 ~ |
  a4 b8 c |
  c8. a16 a8 d |
  d4. b8 |
  c8. c16 fs,8 fs |
  g2 ~ |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*15
  r4
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key g \major
  g8. fs16 |
  a8 a g [fs] |
  g4. b,8 |
  c8. b16 g'8 e |
  d2 ~ |
  d4 g8 a |
  a8. fs16 fs8 a |
  b4. g8 |
  e8. e16 d8 c |
  b2 ~ |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Bên Chúa, tôi nương náu,
      sao các ngươi dám bảo hồn tôi:
      Trốn đi như chim sẻ bay về ngàn.
      Kìa quân gian tà trương nỏ nạp tên,
      nấp bóng đêm bắn trộm người lành.
      Khi nền móng cương thường nát tan,
      người công chính con làm được chi?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đây Chúa luôn minh xét,
	    khinh ghét ai thích việc tàn hung,
	    Trút mưa bao tai họa trên đầu họ.
	    Vì Chúa chính trực thích điều thẳng ngay,
	    Mưa diêm lửa xuống kẻ bạo tàn.
	    Ai người sống ngay lành chính trung
	    được chiêm ngưỡng tôn nhan Ngài liên.
    }
  >>
  \set stanza = "ĐK:"
  Nhưng còn có Chúa trong thánh điện,
  Ngai tòa tận cõi trời cao,
  Đôi mắt Chúa nhìn vào cõi thế,
  xem xét hết mọi phàm nhân.
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
  page-count = 1
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
}

TongNhip = {
  \key bf \major \time 2/4
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
