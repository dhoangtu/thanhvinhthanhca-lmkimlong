% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Hướng Nhìn Về Chúa" }
  composer = "Tv. 122"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 b16 b |
  c8 c a a |
  d4. e8 |
  a,8. a16 c8 d |
  g,4 r8 \bar "||" \break
  
  a8 |
  b4. e,16 a |
  a4. fs8 |
  g g e (d) |
  d4 r8 b' |
  c4. c16 c |
  e,4. d8 |
  g fs g (a) |
  b4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g16 g |
  a8 a g e |
  fs4. g8 |
  fs8. fs16 e8 fs |
  g4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Con đưa mắt hướng nhìn về Chúa,
  Đấng ngự trị trên cõi trời.
  <<
    {
      \set stanza = "1."
      Như mắt của gia nhân nhìn tay ông chủ hoài,
      Như mắt những nữ tỳ nhìn tay bà chủ mãi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Đôi mắt hằng đăm chiêu nhìn lên không mỏi rời,
	    Trông Chúa đến lúc nào Ngài dủ tình thương tới.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin Chúa dủ thương con bị khinh khi bẽ bàng,
	    Tâm trí mãi hứng chịu bọn kiêu ngạo phỉ báng.
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
