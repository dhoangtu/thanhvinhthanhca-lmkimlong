% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Giêrusalem Tôn Vinh Chúa"
  composer = "Tv. 147"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  b8. b16 b8 b |
  c4. c8 |
  a4 a |
  b2 |
  a8. a16 a8 a |
  e4. e8 |
  d4 fs8 a |
  g2 \bar "|." \break
  
  g4. g16 (a) |
  b8. g16 e8
  <<
    {
      \voiceOne
      g8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.6
      \tweak font-size #-2
      \parenthesize
      g16
      \once \override NoteColumn.force-hshift = #-1.3
      \tweak font-size #-2
      \parenthesize
      g
    }
  >>
  \oneVoice
  a4 \tuplet 3/2 { c8 e c } |
  a4. fs8 |
  d' d4 c8 |
  b4 r8 b |
  g4.
  <<
    {
      \voiceOne
      g8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.5
      \tweak font-size #-2
      \parenthesize
      a8
    }
  >>
  \oneVoice
  a8. b16 b8 g |
  e4 \tuplet 3/2 { e8 e fs } |
  d4. d8 |
  a' a4 a8 |
  g2 \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  g8. g16 g8 g |
  e4. e8 |
  fs4 fs |
  g2 |
  d8. d16 d8 d |
  c4. c8 |
  b4 d8 c |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Giê -- ru -- sa -- lem hỡi hãy tôn vinh Chúa,
  Si -- on mau dâng lời ca ngợi Thiên Chúa ngươi.
  <<
    {
      \set stanza = "1."
      Ngài củng cố then cửa nhà ngươi,
      con cái trong thành Ngài giáng phúc thi ân,
      Thiết lập bình an khắp cõi sơn hà
      Tinh hoa lúa mì, Ngài ban cho dư đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Lời Ngài phán mau lẹ chạy đi,
	    ban bố chỉ thị truyền xuống cõi dương gian
	    Tuyết tựa \markup { \italic \underline "lông" }
	    chiên Chúa đã trải dài,
	    Gieo sương buốt lạnh tựa như tung tro bụi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngài để nước đông lại thành băng,
	    mưa đá liên hồi từng miếng Chúa tung gieo,
	    Tiếng Ngài truyền ra khiến chúng tan liền,
	    Nghe hơi thở Ngài biển sông nay tuôn tràn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Truyền luật phapts cho nhà
	    \markup { \italic \underline "Ít - ra -" }
	    en,
	    Gia -- cóp lãnh nhận lời Thánh ước Chúa ban,
	    Chúa chẳng \markup { \italic \underline "cho" }
	    ai biết thánh chỉ Ngài,
	    không dân nước nào được ưu tiên như vậy.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
