% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Danh Ngài Cả Sáng"
  composer = "Tv. 113B"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e8 |
  c c16 c f8 e |
  d4 r8 g ~ |
  g f a g |
  e4 r8 a |
  a a16 a g8 \slashedGrace { a16 _( } c8) |
  d4 b8 b ~ |
  b b d c |
  c2 \bar "||"
  
  g8. g16 g8 e |
  f4. a8 |
  c8. c16 d,8 f |
  g4 r8 e'16 e |
  d8 b b16 (c) a8 |
  g4. a8 |
  d,8 d16 d f8 g |
  c,4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 |
  c c16 c f8 e |
  d4 r8 b ~ |
  b d c b |
  c4 r8 c |
  f f16 f e8 [e] |
  f4 d8 d ~ |
  d d f e |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Xin đừng làm rạng rỡ chúng con,
  vâng lạy Chúa xin đừng.
  Nhưng xin cho danh Ngài cả sáng,
  vì Ngài thành tín yêu thương.
  <<
    {
      \set stanza = "1."
      Sao chư dân lại hỏi:
      Thiên Chúa chúng rầy ở đâu?
      Chúa chúng ta ngự ở trên trời,
      Muốn gì là Ngài đã tác thành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chư dân tin thần tượng
	    do chính chúng nhồi nặn nên,
	    Có lỗ tai mà chẳng nghe gì,
	    Có miệng mà đành im thít hoài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ai tin nơi thần tượng
	    cho chúng giống tượng thần luôn
	    Có tứ chi mà chẳng di động,
	    Cổ họng nghẹn hoài không phát lời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ít -- ra -- en cậy tin
	    nên Chúa đã độ trì cho,
	    Hết những ai bền vững tin cậy,
	    Chính Ngài là mộc khiên giữ gìn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Xin thi ân rộng rãi
	    cho chúng với đoàn tử tôn,
	    Chúa tác sinh toàn cõi đất trời,
	    Phúc lành Ngài rộng ban xuống đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Thiên cung nay Ngài ngự,
	    ban trái đất tặng nhân gian,
	    Cõi chết ai nào tán dương Ngài,
	    Chỉ người nào còn sống chúc tụng.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 8\mm
  bottom-margin = 8\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
