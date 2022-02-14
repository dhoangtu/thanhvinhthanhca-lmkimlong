% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nếu Chúa Không Xây Nhà" }
  composer = "Tv. 126"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 c8 c |
  a (g4) f16 (e) |
  c4 r8 g |
  c8. c16 e8 (f) |
  \slashedGrace { a16 ( } g2) ~ |
  g8 c16 (ef) g,8 c16 (ef) |
  c4. a16 (g) |
  c,8 c r c |
  c e4 f8 |
  \slashedGrace { a16 ( } g2) ~ |
  g8 c16 (ef) g, (c)
  \afterGrace a8 ({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  e (f) \slashedGrace { a16 ( } g4) c,16 (e) |
  f2 \bar "||"
  
  c4 e8 (f) |
  a g r c ~ |
  c g16 (c) \slashedGrace { \once \stemDown ef16 ^( } c4) ~ |
  c8 c e, e16 (f) |
  g8 \slashedGrace { a16 ( } g8) r f16 (e) |
  c2 |
  g4 b!8 (c) |
  e d r c ~ |
  c e16 (f) \slashedGrace { a16 ( } g4) ~ |
  g c c a |
  g f r e |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Nếu Chúa không xây nhà,
  Thợ nề mà tổn sức cũng bằng luống công.
  (ơ) thành trì mà Ngài không canh giữ,
  trấn thủ đêm ngày cũng bằng không.
  <<
    {
      \set stanza = "1."
      Dù bạn thức khuya hay dậy sớm khó nhọc uổng công,
      nếm ưu phiền
      Còn kẻ Chúa thương dù yên giấc
      Chúa vẫn luôn ban cho đầy dư.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này đàn cháu con trong nội thất
	    chính là hồng ân Chúa ban tặng.
	    Và những đứa con thời xuân sắc
	    giống mũi tên dũng nhân cầm tay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Thực hạnh phúc ai mang đầy ống
	    rất nhiều lọai tên giống như vậy.
	    Họ chẳng hổ ngươi hồi tranh chấp
	    với đối phương ở ngay quyền môn.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
