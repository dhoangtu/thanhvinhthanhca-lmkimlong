% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Van Xin Ngài" }
  composer = "Tv. 5"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8. a16 |
  a8 gs4 e8 |
  c'4 b8 e |
  e8. e16 e8 c |
  a b4. ~ |
  b4 e,8 c' |
  c8. b16 a8 gs |
  b e,4 e8 |
  b' c gs4 |
  a2 \bar "||"
  
  a8. a16 b8 a |
  gs4. e16 c' |
  c8. a16 d8 d |
  e2 ~ |
  e4 d8 c16 (d) |
  e8 (d16 c) a8 b |
  b4. b16 b |
  e,8 b' c16 (b) gs8 |
  a2 ~ |
  a4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8. a16 |
  a8 gs4 e8 |
  a4 a8 a |
  gs8. gs16 a8 a |
  f e4. ~ |
  e4 e8 a |
  a8. e16 f8 e |
  d c4 c8 |
  d e e4 |
  c2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Con van xin Ngài,
  lạy Chúa, từ sáng sớm Chúa đã nhậm lời con,
  Từ sáng sớm con thân trình ước nguyện,
  rồi chăm chú đợi trông.
  <<
    {
      \set stanza = "1."
      Xin nghe tiếng van nài
      và thấu suốt điều con rên xiết,
      Ôi lạy Chúa là Vua con,
      xin nghe lời kêu cứu của con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Do ân nghĩa cao dầy,
	    được tiến bước vào nơi cung thánh,
	    Con phục bái và suy tôn,
	    Uy Danh Ngài con kính sợ liên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin theo đức công bình mà hướng dẫn
	    để con đưa bước,
	    Quân thù vẫn rình theo con,
	    manh tâm bày mưu kế hại con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai nương náu bên Ngài
	    nguyện ước sẽ được luôn vui sướng,
	    Ai mộ mến Thần Danh luôn,
	    hân hoan nhờ tay Chúa chờ che.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
