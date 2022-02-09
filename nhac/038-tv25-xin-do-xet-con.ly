% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Dò Xét Con" }
  composer = "Tv. 25"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 g8 d |
  bf'8. a16 g8 (bf) |
  c2 |
  d8. d16 ef8 d |
  c8 c4 c8 |
  bf8. d16 g,8 a ~ |
  a4 g8 a16 (g) |
  ef8. d16 bf'8 a |
  c2 |
  d8. d16 ef8 c ~ |
  c d bf4 |
  a8. a16 bf8 g ~ |
  g4 \bar "||" \break
  
  g8 g |
  ef4 c8 c |
  d4. d8 |
  a'8. a16 bf8 a ~ |
  a g a g |
  fs2 ~ |
  fs4 g8 g |
  ef4 d8 (g) |
  a4. c8 |
  c8. c16 b8 a ~ |
  a a bf fs |
  g2 ~ |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 d |
  bf'8. a16 g8 (bf) |
  c2 |
  bf8. bf16 c8 bf |
  a a4 a8 |
  g8. f16 ef8 d ~ |
  d4 g8 a16 (g) |
  ef8. d16 bf'8 a |
  c2 |
  bf8. bf16 g8 a ~ |
  a f g4 |
  d8. d16 c8 bf ~ |
  bf4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Xin dò xét và thử con,
  xin nung đúc tâm can con,
  tôi luyện trí lòng con.
  Ân nghĩa Ngài ở trước mặt con
  Nên con vững tâm bước đi trong chân lý Ngài.
  <<
    {
      \set stanza = "1."
      Xin phân xử mọi việc con
      vì con luôn bước đi theo đức trọn lành.
      Con tin tưởng vào Chúa nên con không do dự,
      nào núng chuyển lay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Quân gian xảo, bọn tà tâm,
	    phường vô luân bất trung con quyết xa lìa,
	    Tay con rửa thuần khiết hân hoan
	    lên bàn thờ vang tiếng tạ ơn.
	    
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con mong mỏi được truyền rao kỳ công
	    ôi xiết bao tay Chúa đã làm.
	    Con yêu chuộng nhà Chúa,
	    nơi vinh quang tỏa rạng nơi Chúa hiển linh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Con ăn ở thực thẳng ngay,
	    Ngài ra tay cứu nguy thương xót con cùng.
	    Luôn thanh thản nhẹ bước,
	    ca vang nơi công hội vinh chúc Ngài liên.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
