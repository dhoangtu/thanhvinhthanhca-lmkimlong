% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Lời Ca Của Tôi" }
  composer = "Is. 12,1-6"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  a'2 |
  g8. g16 e8 f |
  d4. d16 d |
  d8 e f a |
  g4 r8 g |
  g2 |
  g8. f16 a8 f |
  e4. a,16 a |
  f'8 e cs cs |
  \partial 4. d4 r8 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  \partial 8 fs8 |
  fs4. d8 |
  g4 g8 e |
  fs4. fs16 fs  |
  e8 e g gs |
  a4 r8 fs |
  fs b g4 |
  g8. g16 b8 d |
  cs4. a8 |
  e'4 e8 cs |
  d4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*9
  r4.
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  d8 |
  d4. c!8 |
  b4 e8 c |
  d4. d16 d |
  a8 a e' d |
  cs4 r8 d |
  d g e4 |
  e8. e16 g8 g |
  a4. fs8 |
  g4 a8 a |
  fs4 r8 \bar "|."
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa con dâng lời cảm tạ
      Vì Ngài từng thịnh nộ với con,
      Nhưng nay cơn giận đã nguôi rồi,
      Ngài lại khứng ban niềm ủi an.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nào hãy nâng cung đàn hát mừng
	    Sự nghiệp Người rạng tỏ khắp nơi,
	    Hân hoan nơi nguồn suối cứu độ,
	    Bạn hãy múc nước tràn đầy đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngày đó ngươi vui mừng nói rằng:
	    Nguyện cầu và tạ ơn Chúa đi,
	    Cao rao công trình Chúa mọi miền,
	    Tụng niệm Thánh Danh Ngài huyền siêu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Nào hỡi Si -- on hãy hát mừng
	    Vì Ngài hằng ngự ở giữa ngươi,
	    Reo vang: Ôi thực Chúa vĩ đại
	    Là Vị Thánh của Ít -- ra -- en.
    }
  >>
  \set stanza = "ĐK:"
  Chính Chúa là Đấng cứu độ tôi,
  tôi trông cậy và chẳng sợ chi.
  Ngài là sức mạnh, là lời ca của tôi,
  là sức tế độ tôi.
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
