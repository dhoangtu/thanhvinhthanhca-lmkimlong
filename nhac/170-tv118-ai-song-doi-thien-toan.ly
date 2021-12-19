% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Quân Vương Khắp Gian Trần"
  composer = \markup {
    \column {
      \line { "Tv. 118" }
      \line { "đoạn 1 (câu 1-8)"  }
    }
  }
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  b' (a) g4 |
  g8. a16 e8 e |
  d4. d16 d |
  g8 a16 (g) fs8 g16 (a) |
  b4 r8 g |
  e' (d) c4 |
  c8. c16 a8 d |
  d4. c16 c |
  b8 a d fs, |
  g2 \bar "||" \break
  
  g8. g16 e8 d |
  b'4. b16 c |
  a8 e' e cs |
  d2 |
  c8. a16 g8 a16 (b) |
  e,4. e16 a |
  fs8 e fs d |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d8 |
  b' (a) g4 |
  g8. a16 e8 e |
  d4. d16 c |
  b8 [b] d [d] |
  g4 r8 g |
  c (b) a4 |
  a8. a16 g8 g |
  fs4. a16 a |
  g8 d d d |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hạnh phúc thay ai sống đời thiện toàn,
  Hằng thực thi giới luật của Chúa.
  Hạnh phúc thay ai tuân hành ý Chúa,
  Những nhất tâm tìm kiếm Ngài luôn.
  <<
    {
      \set stanza = "1."
      Không thi hành điều ác,
      nhưng cứ đường lối Chúa mà đi
      Chúa ban hành huấn lệnh
      truyền chúng con tuân giữ trọn luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Con nay hằng bền vững đưa bước
	    nhằm đúng thánh chỉ luôn
	    Để con khỏi hổ thẹn
	    nhìn những mệnh lệnh Chúa truyền ban.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con dâng lời cảm mến
	    khi biết được huấn giới thẳng ngay
	    Nhất tâm hằng gìn giữ,
	    nguyện Chúa thương không dẫy từ con.
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
