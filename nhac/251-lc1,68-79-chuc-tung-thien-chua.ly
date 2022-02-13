% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúc Tụng Thiên Chúa" }
  composer = "Lc. 1,68-79"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g8 |
  c, d e (f) |
  e8.
  <<
    {
      \voiceOne
      c'16
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \tweak font-size #-2
      \parenthesize
      e,16
    }
  >>
  \oneVoice
  c'8 b |
  a4. a16 a |
  g8 a f g |
  e2 ~ |
  e4 r8 \bar "||"
  g16 g |
  c8 c b c |
  d2 ~ |
  d8 a b c |
  g4 g8 e' |
  d8. c16 b8 d |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*5
  r4.
  g16 f |
  e8 e d e |
  g2 ~ |
  g8 f d f |
  e4 e8 g |
  fs8. fs16 g8 g |
  e4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúc tụng Thiên Chúa là Chúa Ít -- ra -- en,
      Đã viếng thăm cứu chuộc dân Ngài.
      Từ dòng dõi trung thần Đa -- vít
      Ngài cho xuất hiện Vị Cứu Tinh uy quyền giúp ta.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chúa dùng ngôn sứ mà phán hứa xưa kia:
	    Sẽ cứu ta thoát khỏi quân thù.
	    Khỏi bàn tay bao kẻ ghen ghét,
	    Vì Giao ước Ngài trọn nghĩa ân với tiền bối ta.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa thề hứa với tổ \markup { \italic \underline "phụ" }
	    Ap -- bra -- ham
	    Sẽ cứu ta thoát khỏi quaan thù.
	    Và để ta không còn sợ hãi,
	    Hầu sống thánh thiện,
	    trọn kiếp ta phụng thờ Chúa liên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Tước hiệu ngôn sứ của chính Đấng Tối Cao,
	    hãy lãnh nhận, hỡi Hài nhi này,
	    Làm tiền phong mở đường cho Chúa,
	    Ngài sẽ cứu độ,
	    Và thứ tha muôn tội chúng dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa đầy nhân ái gửi đến viếng thăm ta
	    Ánh Thái Dương mãi tận cung trời.
	    Để rạng soi ai ngợp tăm tối,
	    ngồi nơi tử thần,
	    Và dẫn ta trên đường vĩnh an.
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
