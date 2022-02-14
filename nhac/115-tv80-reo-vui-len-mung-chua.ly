% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Reo Vui Lên Mừng Chúa" }
  composer = "Tv. 80"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a8. a16 a8 f |
  bf4. bf8 |
  g g4 bf8 |
  a2 |
  f8. g16 e8 d |
  c4. a'8 |
  a g4 bf8 |
  c2 |
  r8 f, f f |
  bf8. bf16 a8 g |
  r8 e e e |
  f8. f16 g8 c, ~ |
  c2 |
  r8 f f f |
  bf8. bf16 a8 g |
  r8 g g g |
  c8. e,16 g8 f ~ |
  f4 r8 \bar "||"
  
  a16 e |
  e4 \tuplet 3/2 { g8 bf a } |
  g4. a8 |
  bf8. bf16 \tuplet 3/2 { bf8 g bf } |
  c4 r8 \slashedGrace { f,16 ( } a) f |
  d4 \tuplet 3/2 { g8 g a } |
  d,4. d8 |
  c8. g'16 \tuplet 3/2 { e8 g f } |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8. f16 f8 d |
  g4. g8 |
  e e4 g8 |
  f2 |
  d8. e16 c8 b! |
  c4. f8 |
  f e4 d8 |
  e2 |
  r8 f f ef |
  d8. g16 f8 e |
  r8 c c c |
  d8. d16 b!8 c ~ |
  c2 |
  r8 a a a |
  d8. g16 f8 e |
  r8 e e e |
  e8. c16 bf8 a ~ |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Reo vui lên mừng Chúa,
  Đấng trợ lực chúng ta.
  Hò vang dậy đi nào kính Chúa nhà Gia -- cop.
  Hòa nhịp điệu trống hát vang lên,
  Dìu dặt dạo muôn cung sắt cầm,
  Tù và nào rúc mãi lên đi,
  mừng ngày đại lễ của chúng ta.
  <<
    {
      \set stanza = "1."
      Đó là luật cho Is -- ra -- el,
      Nghi lễ kính Chúa nhà Gia -- cóp,
      Chỉ thị này Giu -- se lãnh nhận,
      khi rời Ai -- cập bước ra đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ta hạch tội, ơi Is -- ra -- el,
	    Ngươi vẫn bất chấp lời tuyên cáo:
	    Những thần tượng chư dân bái lạy,
	    ngươi đừng đem về để suy tôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ách nặng nề mang trĩu trên vai,
	    Ta đã cất hết cùng lao tác,
	    Lúc ngặt nghèo ngươi đang khấn cầu,
	    Ta đà thương tình lắng tai nghe.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ta thực là Thiên Chúa riêng ngươi,
	    Ta đã cứu thoát và ban phúc,
	    Thế vậy mà ngươi luôn cứng lòng,
	    coi thường bao lời lẽ Ta khuyên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Mong bọn họ nay biết nghe Ta,
	    Đưa bước đúng lối đường Ta dẫn,
	    Lũ địch thù, bao quân ác tàn
	    Ta thề chinh phạt chúng tiêu tan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao địch thù xin đến suy tôn,
	    Muôn kiếp chúng sẽ phải kinh khiếp,
	    Lấy mật rừng, tinh hoa lúa mì,
	    Ta dành nuôi mập béo dân Ta.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
