% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Biết Lấy Chi Đền Đáp" }
  composer = "Tv. 115"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a16 bf |
  a8 g16 (a) c8 d |
  d4. c8 |
  bf d4 bf8 |
  a4 r8 bf16 bf |
  a8 g g a16 (g) |
  ef4. ef8 |
  d fs4 a8 |
  \partial 4. g4 r8 \bar "||"
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key g \major
  \partial 8 d'16 d |
  b8 g c b |
  a4 \tuplet 3/2 { fs8 g a } |
  d,8. e16 c'8 a |
  b4 r8 d16 d |
  e8 b c d |
  a4 \tuplet 3/2 { fs8 g a } |
  d,8. b'16 a8 fs |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*7
  r4.
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key g \major
  fs16 fs |
  g8 e a g |
  d4 \tuplet 3/2 { d8 e c } |
  b8. c16 e8 fs |
  g4 r8 b16 b |
  c8 g a g |
  fs4 \tuplet 3/2 { d8 e c } |
  b8. d16 c8 d |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tôi vững tin cả khi đã nói:
      ôi nhục nhã ê chề,
      Đã thốt lên trong cơn hốt hoảng:
      mọi người đều dối gian.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tôi khắc ghi điều tôi khấn hứa,
	    thi hành trước dân Ngài
	    Cái chết nơi ai luôn tín thành với Ngài thực quý thay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vâng chính con là tôi tớ Chúa,
	    con tỳ nữ của Ngài
	    Chính Chúa thương ra tay
	    tháo cởi xích xiềng buộc trói con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con hiến dâng Ngài lễ tế,
	    xin thành kính cảm tạ
	    Trước chúng dân con xin giữ trọn
	    những điều thề hứa xưa.
    }
  >>
  \set stanza = "ĐK:"
  Biết lấy chi đền đáp Chúa đây,
  vì muôn phúc lành Ngài đã tặng ban.
  Xin nâng chén mừng ơn cứu độ
  và xin khấn cầu thánh danh Ngài liên.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
