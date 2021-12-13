% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Tôi Tìm Kiếm Chúa"
  composer = "Tv. 76"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 \tuplet 3/2 { g8 d bf' } |
  bf4 \tuplet 3/2 { a8 g d' } |
  d4 r8 ef16 d |
  c8 c c c |
  c c4 d8 |
  bf4 r8 bf16 bf |
  c8 d c c |
  bf g4 bf8 |
  a2 ~ |
  a4 fs16 (g) a8 |
  d4. bf8 |
  a bf4 c8 |
  d4 d16 (ef) d8 |
  c4. c8 |
  d bf4 a8 |
  g2 ~ |
  g4 \bar "||" \break
  
  f!?8 f |
  g4 \tuplet 3/2 { g8 d d } |
  bf'4. a16 c |
  d4 \tuplet 3/2 { d8 bf a } |
  g2 ~ |
  g4 g8 ef |
  d4 \tuplet 3/2 { g8 fs g } |
  a4. a16 c |
  d4 \tuplet 3/2 { d,8 bf' a } |
  g2 ~ |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  \tuplet 3/2 { g8 d bf' } |
  bf4 \tuplet 3/2 { a8 g d' } |
  d4 r8 c16 bf |
  a8 a a a |
  a a4 fs8 |
  g4 r8 g16 g |
  a8 bf a a |
  g ef4 g8 |
  d2 ~ |
  d4 fs16 (g) a8 |
  d4. g,8 |
  fs g4 a8 |
  bf4 bf16 (c) bf8 |
  a4. a8 |
  bf g4 fs8 |
  g2 ~ |
  g4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Trong ngài khốn quẫn, tôi tìm kiếm Chúa,
  suốt đêm thâu tay tôi vươn lên không biết mỏi,
  và hồn tôi đâu thiết chi những lời ủi an.
  Tưởng nhớ Ngài, tôi thở than rên xiết,
  gẫm suy liên nên khí lực suy tàn.
  <<
    {
      \set stanza = "1."
      Ngài làm con không hề chợp mắt,
      lòng xao xuyến nói chẳng nên lời,
      Nhớ tưởng hoài bao ngày xa cũ,
      Hồn e ấp từng tháng năm qua.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ngồi tàn canh nghe lòng thầm thì,
	    và tâm trí cứ tự hỏi hoài:
	    Có phải Ngài xua từ luôn mãi
	    Và muôn kiếp đành dứt yêu thương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tình Ngài yêu nay rồi cạn mãi,
	    lời minh ước dứt bỏ muôn đời,
	    Chúa giận hờn quên lòng thương xót
	    Và phong kín tình mến bao la.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Lòng quặn đau bao lần thầm nghĩ:
	    rầy Thiên Chúa hết ra tay rồi,
	    Những công trình xưa Ngài thi thố
	    Lòng con vẫn hằng gẫm suy luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Thần nào đâu cao trọng bằng Chúa,
	    lạy Thiên Chúa thánh thiêng muôn trùng,
	    Đã thể hiện bao kỳ công đó,
	    Ngàn dân nước từng thấy uy phong.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Ngài hiển linh mây tầng vọng tiếng,
	    đổ mưa xuống khắp nẻo tuôn tràn,
	    Nước trờ mình rung động kinh khiếp,
	    Vực sâu cũng sợ hãi run lên.
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
  %page-count = #1
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
