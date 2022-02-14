% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Đấng Báo Phục" }
  composer = "Tv. 93"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  bf4. d16 ef |
  c4 r8 c |
  g'4. g16 g |
  f8 a c bf |
  bf2 |
  d8. d16 a8 a |
  bf4. bf16 c |
  f,4 \tuplet 3/2 { ef8 bf' g } |
  f8. g16 \tuplet 3/2 { ef8 c f } |
  bf,4 \bar "||" \break
  
  d8 c |
  bf4 bf8 ef ~ |
  ef4 ef8 d |
  c4 g'8 f ~ |
  f bf bf bf |
  a2 ~ |
  a4 bf8 g |
  f4 d'8 d ~ |
  d c c d |
  g,4 g8 a |
  g f4 c'8 |
  bf2 ~ |
  bf4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*9
  r4
  d8 c |
  bf4 bf8 ef ~ |
  ef4 ef8 d |
  c4 g'8 f ~ |
  f ef d d |
  f2 ~ |
  f4 g8 ef |
  d4 bf'8 bf ~ |
  bf a a f |
  e!4 e8 f |
  c d4 ef8 |
  d2 ~ |
  d4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa là Đấng báo phục,
      lạy Chúa Đấng báo phục xin hãy quang lâm.
      Đấng xét xử trần gian xin đứng dậy
      Trả lũ kiêu căng xứng công việc chúng làm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Dân tộc Chúa kén chọn bị chúng áp bức
	    và uy hiếp khôn ngơi,
	    chúng giết sạch kiều cư trên đất này,
	    Tàn sát cô nhi, bách hại người góa bụa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúng rằng: Chúa thấy gì,
	    này lũ dốt nát và ngu ngốc kia ơi,
	    Đấng gắn liền vành tai,
	    vo mắt tròn lại chẳng nghe chi,
	    lẽ đâu chẳng thấy gì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con người tính toán gì là Chúa biết rõ
	    tựa cơn gió bay qua.
	    Diễm phúc kẻ thành tâm nghe Chúa
	    dậy được sống an vui dẫu trong ngày mắc nạn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa nào có khước từ,
	    ruồng rấy dân riêng Ngài luôn mãi yêu thương,
	    Pháp lý sẽ trở lui nơi pháp đình,
	    vạn kiếp an vui đến cho người chính trực.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai người sẽ đứng dậy hộ giúp tôi
	    đương đầu bao lũ gian manh,
	    Sát cánh cự lại bao quân ác tàn
	    mà Chúa không thương chắc tôi lặng tiếng hoài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Lúc miệng đã thốt lời:
	    chùn bước, chính Chúa lại nâng đỡ con đi,
	    Lúc chất đầy sầu lo trong cõi lòng
	    Ngài ủi an con khiến tâm hồn khởi mừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa là chính lũy thành,
	    là núi rất vững vàng tôi đến nương thân,
	    Chúa sẽ triệt hạ đi quân ác tàn,
	    tội chúng gây ra trút trên đầu chúng này.
    }
  >>
  \set stanza = "ĐK:"
  Đến bao giờ, lạy Chúa,
  đến bao giờ ác nhân cứ mãi sướng vui.
  Lũ gian tà cứ mãi ba hoa hỗn xược,
  vênh váo ngang tàng khắp nơi.
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
  ragged-bottom = ##t
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
