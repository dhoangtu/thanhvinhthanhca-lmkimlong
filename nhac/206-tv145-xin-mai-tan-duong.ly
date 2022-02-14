% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Mãi Tán Dương" }
  composer = "Tv. 145"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  b' b r c ^> ~ |
  c b g b |
  a4 r8 a |
  fs fs r g ^> ~ |
  g a a g |
  d2 ~ |
  d4 d8 c' |
  b b r a ^> ~ |
  a gs a b |
  c4 r8 c |
  b e, r d ^> ~ |
  d b' a fs |
  g2 ~ |
  g4 \bar "||" \break
  
  fs8 g |
  e8. e16 d8 d |
  b'4 r8 b16 g |
  g8 g e' cs |
  d2 ~ |
  d4 b8 d |
  c8. a16 a8 a16 d |
  fs,4 r8 fs16 e |
  d8 d a' fs |
  g2 ~ |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d8 |
  g g r a ~ |
  a g e g |
  d4 r8 cs |
  d d r e ~ |
  e d c c |
  b2 ~ |
  b4 b8 e |
  g g r d ~ |
  d e fs fs |
  a4 r8 e |
  d c r b ~ |
  b c cs d |
  b2 ~ |
  b4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hồn tôi ơi, hãy ca tụng Chúa đi.
  Suốt cuộc đời xin mãi tán dương Ngài.
  Còn sống bao lâu, xin được luôn vui sướng,
  tấu cung đàn mà hát khen Ngài thôi.
  <<
    {
      \set stanza = "1."
      Đừng tin cậy nơi hàng quyền thế,
      Nơi người phàm nào cứu được ai,
      Vừa tắt hơi là về cùng cát bụi,
      Ước mơ nhiều ngày ấy vụt tan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Vinh phúc thay ai cậy nhờ Chúa,
	    Vững một lòng thờ Chúa mà thôi,
	    Ngài tác sinh biển rộng cùng đất trời,
	    Với muôn loài vùng vẫy ngược xuôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Thiên Chúa luôn một lòng thành tín,
	    Ai nghèo hèn Ngài phát của ăn.
	    Xử chí công cùng người bị áp lực,
	    Cứu ai bị hạn hiếp tù lao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Mở mắt cho ai bị mù tối,
	    Lưng khòm được Ngài uốn thẳng lên.
	    Ngài mến thương kẻ nào hằng chính trực,
	    Phá mưu đồ của lũ tàn hung.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Người bang trợ quả phụ hèn yếu
	    Luôn độ trì mọi khách hiều cư.
	    Này Si -- on ngàn đời Ngài thống trị,
	    Nắm vương quyền vạn kiếp ngàn thu.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 1.5))
}

TongNhip = {
  \key g \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
