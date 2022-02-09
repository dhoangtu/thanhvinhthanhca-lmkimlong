% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hát Lên Bài Tân Ca" }
  composer = "Tv. 97"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a8 |
  g4 c,8 f |
  f8. e16 f8 (g) |
  a4 r8 f |
  bf4 g8 g |
  g c a16 (g) f8 |
  g2 ~ |
  g4 c,8 a' |
  a4. f8 |
  f g4 a8 |
  d,4 c8 a' |
  g4. c8 |
  c (bf) g4 |
  f2 ~ |
  f4 r \bar "||" \break
  
  a8. f16 \tuplet 3/2 { g8 g a } |
  c,4 \tuplet 3/2 { bf'8 g a } |
  a4. e16 e |
  \slashedGrace { e16 ( } f4) \tuplet 3/2 { g8 d e } |
  c2 |
  bf'4. d16 d |
  g,4 \tuplet 3/2 {
  <<
    {
      \voiceOne
      g8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #2
      \tweak font-size #-2
      \parenthesize
      e
    }
  >>
  \oneVoice
  e bf' } |
  c4. c,8 |
  g'4 \tuplet 3/2 { e8 g f } |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 |
  g4 c,8 f |
  f8. e16 d8 (c) |
  f4 r8 ef |
  d4 f8 f |
  e e f [d] |
  c2 ~ |
  c4 c8 f |
  f4. d8 |
  d c4 c8 |
  bf4 a8 f' |
  e4. d8 |
  e4 e |
  f2 ~ |
  f4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hát lên bài Tân Ca ngợi khen Chúa,
  vì Chúa đã thực hiện biết bao kỳ công
  Ngài chiến thắng nhờ ban tay dũng mạnh,
  nhờ cánh tay chí thánh của Ngài.
  <<
    {
      \set stanza = "1."
      Chúa biểu dương ơn cứu độ trước mặt chư dân
      Và mạc khải đức công chính Ngài,
      Ngài đã nhớ lại ân tình tín nghĩa
      dành cho nhà Is -- ra -- el.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Khắp mọi nơi trên thế trần,
	    khắp nẻo xa xôi
	    Được nhìn tò phúc ân cứu độ,
	    Nào khắp cõi trần reo hò kính Chúa,
	    mừng vui đàn hát lên đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hãy dạo nên cung sắt cầm,
	    tiếng nhạc du dương,
	    Lời dìu dặt hát khen Chúa Trời,
	    Họa với tiếng kèn,
	    \markup { \italic \underline "tù" }
	    và rúc mãi,
	    mừng Chúa là Đức Vua ta.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Hãy hò vang lên, vũ hoàn với toàn cư dân
	    Cùng biển cả với muôn hải vật,
	    Nào hỡi núi đồi chung lời hát kính,
	    dòng sông nào vỗ tay lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Hát mừng nơi nhan thánh Ngài
	    bởi Ngài quang lâm
	    Để hiển trị khắp cả thế trần
	    Theo lẽ chính trực,
	    theo đường công minh,
	    Ngài đến xử xét muôn dân.
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
  page-count = #1
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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
