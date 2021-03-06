% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Việc Chúa Làm" }
  composer = "Is. 38,10-14.17-20"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e16 f \bar ".|:"
  g8. g16 \tuplet 3/2 { a8 f g } |
  e4 r8 f16 d |
  d8. d16 \tuplet 3/2 { a'8 a fs } |
  g4 r8 g16 c |
  c8. c16 \tuplet 3/2 { b8 e b } |
  a4 r8 b16 a |
  g8. f16 \tuplet 3/2 { d8 g d } |
  \set Score.repeatCommands = #'((volta "1"))
  c4 r8 e16 f
  \set Score.repeatCommands = #'((volta #f) (volta "2") end-repeat)
  c4 r8 c16 d
  \set Score.repeatCommands = #'((volta #f))
  e8 e d f |
  g g r e16 e |
  g8 f e g |
  a a r c |
  b c16 a b8 c |
  d4 r8 g, |
  e' e16 d b8 d |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*9
  r4. d8 |
  c b r c16 c |
  e8 d c e |
  f f r e |
  g e16 c d8 e |
  g4 r8 g |
  c g16 f g8 f |
  e4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      Người ở xa nghe biết việc Ta làm,
      Kẻ ở gần nhận rõ sức mạnh Ta,
      Tại Si -- on quân tội lỗi rụng rời,
      Lũ gian tà run rẩy với kinh hoàng.
      Người công
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    _ _ minh ăn nói hằng đơn thực,
	    Của hối lộ, quà cáp khước từ luôn.
	    Bịt tai không nghe lời nói thâm độc,
	    Nhắm mắt lại bao việc xấu không - - - nhìn.
	    Người như thế sẽ được ở nơi cao.
	    Tìm được nơi ẩn mình trên Núi Đá.
	    Bánh ăn sẽ được luôn cung cấp,
	    và nước uống không hề thiếu đâu.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
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
% kết thúc mã nguồn

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
