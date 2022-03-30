% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Dẫn Con Tới Núi Thánh" }
  composer = "Tv. 42"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 b8 |
  b4 c8 c |
  c8. a16 b8 d |
  g,4 c8 b |
  a4 a8 a |
  a8. a16 fs8 e |
  d4 r8 b' |
  c4. c8 |
  b4 a8 a |
  d4 d8 fs, |
  fs4. e8 |
  d4 a'8 fs |
  g2 \bar "||" \break
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key bf \major
  g8 g ef (d) |
  g4 g8 g |
  a8. bf16 g8 d' |
  d4 r8 ef |
  c4 c8 d |
  bf4. a16 (bf) |
  d,8 d a'16 (bf) a8 |
  g4 r8 <b! g> \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  g8 |
  g4 a8 a |
  a8. fs16 g8 fs |
  e4 e8 g |
  d4 c8 e |
  fs8. e16 d8 c |
  d4 r8 g |
  a4. a8 |
  g4 g8 g |
  fs4 fs8 e |
  d4. c8 |
  b4 c8 d |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Xin thương phái ánh sáng và chân lý Ngài
  dẫn con đi tới núi thánh,
  tới cung điện Ngài,
  Con sẽ tiến tới bàn thờ Chúa,
  đến cùng Ngài hoan lạc của đời con.
  <<
    {
      \set stanza = "1."
      Xin phân xử con,
      biện hộ con chống phường bất nghĩa,
      Chúa ơi xin cứu con khỏi bọn xảo trá gian tà.
      \set stanza = "ĐK."
      Xin
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Sao xua đuổi con, để thù nhân tứ bề áp bức,
	    Chúa ơi xin nhớ con vẫn hằng tìm náu nương Ngài
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Than van làm chi, này hồn ơi chớ thổn thức mãi,
	    vững tin nơi Chúa đi bởi Ngài là Chúa tôi thờ.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
