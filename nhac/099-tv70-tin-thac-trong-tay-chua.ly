% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tín Thác Trong Tay Chúa" }
  composer = "Tv. 70"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  e8. e16 e8 f |
  f4 d8 d |
  e4 d8 c |
  c e a, (c) |
  d4 r8 c |
  f f4 d8 |
  d d f f |
  g4. g8 |
  d' d4 d8 |
  c4 \bar "||" \break
  
  c8. c16 |
  c8 a r a |
  g8. g16 b8 c |
  d2 ~ |
  d4 c8 c |
  d8. e16 c8 d16 (c) |
  a4. a8 |
  g b4 d8 |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*9
  r4
  e8. e16 |
  e8 c r f |
  e8. e16 d8 e |
  g2 ~ |
  g4 a8 a |
  b8. c16 a8 g |
  f4. f8 |
  e d4 f8 |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin nên như núi đá con nương náu,
      như thành trì cứu độ con,
      Vì núi đá và thành trì bảo vệ con là chính Chúa,
      Chúa ơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đưa con xa móng vuốt quân gian ác,
	    xa bọn độc dữ hiểm nguy,
	    Vì chính Chúa là niềm cậy trông
	    của con từ tấm bé Chúa ơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con khôn ngơi cất tiếng tôn vinh Chúa,
	    tay Ngài hằng dắt dìu con,
	    Vì có Chúa là thành trì để ẩn thân,
	    Nguyện mãi tán dương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con đây luôn tín thác trong tay Chúa,
	    loan truyền lộc phúc Ngài ban,
	    Từ tấm bé đà được Ngài thương dậy dỗ
	    và dẫn dắt tới nay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Khi cao niên, xế bóng,
	    van xin Chúa thương tình đừng nỡ bỏ con,
	    Vì khắp chốn địch thù bày mưu gian ác
	    và nhất trí chống con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao vinh hoa Chúa sẽ ban chan chứa,
	    an ủi và vỗ về con,
	    Dù trước đó từng bị vùi dập khổ đâu,
	    rồi Chúa mới kéo lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Theo cung tơ réo rắt con ca hát,
	    đa tạ Ngài cứu độ con,
	    Và nhắc nhớ ngàn đời Ngài luôn công chính,
	    là Đấng Thánh Ich -- diên.
    }
  >>
  \set stanza = "ĐK:"
  Môi con reo hò theo nhịp đàn ngợi khen Chúa,
  Và hồn con Chúa đã cứu độ vui mừng chung tiếng ca.
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
  %system-system-spacing = #'((basic-distance . 0.1) (padding . 1))
  page-count = 1
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
