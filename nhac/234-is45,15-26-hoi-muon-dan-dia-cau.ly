% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hỡi Muôn Dân Địa Cầu" }
  composer = "Is. 45,15-16"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 8 c8 |
  f4. f16 e |
  e4 \tuplet 3/2 { e8 a a } |
  d,4. c16 c |
  c8 e g e |
  e4 r8 a16 d, |
  d8 d f g |
  c4. c16 c
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1
      \parenthesize
      f8
    }
  >>
  \oneVoice
  f f bf |
  g4 r8 g |
  f4. bf16 a |
  g4. e8 |
  e4 \tuplet 3/2 { e8 g g  } |
  d2 ~ |
  d8 d a'16 (bf) g8 |
  a4. g16 e |
  c8 e4 g8 |
  f2 ~ |
  f4 \bar "||"
  
  \pageBreak
  
  c'8 a |
  a8. bf16 bf8 g |
  g2 ~ |
  g8 a a f |
  g8. e16 e8 g |
  c,4. c16 c |
  c8 f e g |
  a4. f16 bf |
  bf8 bf g8 c |
  c2 ~ |
  c4 c8 d |
  d8. bf16 bf8 g |
  g2 ~ |
  g8 a f g |
  c,8. c16 g'8 bf |
  a4 r8 a |
  bf2 ~ |
  bf8 bf g e |
  c4 g'8 e |
  f2 ~ |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*17
  r4
  f8 g |
  f8. g16 g8 f |
  e2 ~ |
  e8 f f d |
  e8. c16 c8 bf |
  c4. c16 c |
  bf8 a c c |
  f4. f16 ef |
  d8 g f f |
  e2 ~ |
  e4 a8 a |
  bf8. g16 g8 f |
  e2 ~ |
  e8 f d bf |
  a8. a16 bf8 g' |
  f4 r8 f |
  g2 ~ |
  g8 d e c |
  a4 bf8 c |
  a2 ~ |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa Is -- ra -- el, lạy Đấng Cứu Độ,
      Ngài thực là Thiên Chúa ẩn thân,
      Những kẻ nào làm nên ngẫu tượng,
      phải nhục nhã thẹn thùng tháo lui,
      Nhưng còn Is -- ra -- el ngàn đời được Chúa cứu độ,
      Vạn kiếp ngàn thu sẽ không hề bị hổ ngươi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lời Chúa, Đấng Muôn Cao tạo tác cõi trời,
	    Nặn địa cầu chu vững bền luôn,
	    không tạo địa cầu hoang vắng hoài,
	    mà để các loài lại trú cư.
	    Đây Ngài đã tuyên ngôn:
	    Ngoài Ngài nào có chúa nào,
	    Chỉ có mình Ta, chỉ Ta là Thiên Chúa thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Này Ta đâu ẩn mình vào lúc phán truyền,
	    Ở một vùng tăm tối tịch liêu,
	    Chẳng dạy dòng tộc Đa -- vít rằng:
	    Hãy tìm \markup { \italic \underline "Ta" }
	    ở vùng trống không.
	    Ta là Chúa cao quang hằng dạy đường lối chính trực,
	    hằng mãi truyền rao lẽ công bình cho chúng nhân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Về đây, ai là người còn sống sót được,
	    Tụ họp từ muôn nước về đây.
	    Những kẻ đần độn khiêng ngẫu tượng,
	    vật bằng gỗ mà giải cứu ai?
	    Mau lại đối chất đi, luận đàm để biết rõ ràng:
	    Điều ấy từ xưa có ai người đã nói nghe.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ngoài Ta đâu mà còn một Chúa khác nào,
	    Chẳng một thần minh cứu độ đâu.
	    Há chẳng phải từ muôn thế hệ,
	    chỉ mình \markup { \italic \underline "Ta" }
	    thực là Chúa sao.
	    Muôn người trước nhan Ta quỳ lạy và khấn ước rằng:
	    Lạy Chúa hiển vinh, Đấng Cứu Độ ban sức thiêng.
    }
  >>
  \set stanza = "ĐK:"
  Hỡi muôn dân khắp cõi địa cầu
  hãy hướng về Ta để được cứu độ,
  Vì một mình Ta là Thiên Chúa,
  ngoài Ta ra đâu còn Chúa khác.
  Ta lấy chính danh Ta mà thề,
  những lời chân thật miệng Ta thốt ra,
  Ta quyết sẽ không khi nào rút lại đâu.
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
  ragged-bottom = ##t
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
