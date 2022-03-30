% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Sự Nghiệp Chúa Lớn Lao" }
  composer = "Kh. 15,3-4"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a8. a16 bf (a) f8 |
  g4. e16 e |
  e8 g f d |
  c4 r8 c |
  g'8. g16 f8 a |
  bf4. g16 c |
  e,8 d c f |
  f4 r8 \bar "|." \break
  
  f16 a |
  g8 g a f |
  d4. c16 f |
  e (f) g8 g g |
  a4 r8 f |
  bf4. g8 |
  g g r c |
  c4. c8 |
  a2 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  f8. f16 g (f) d8 |
  e4. d16 d |
  c8 c d b! |
  c4 r8 a |
  bf8. c16 d8 f |
  g4. e16 d |
  c8 bf bf bf |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ôi Thiên Chúa toàn năng,
  sự nghiệp Ngài lớn lao kỳ diệu.
  Lay Vua cai trị muôn nước,
  đường lối Ngài chân thực công minh.
  <<
    {
      \set stanza = "1."
      Nào có ai không kính sợ Ngài,
      Nào ai chẳng tôn vinh Danh Thánh.
      Lạy Chúa một mình Ngài chí thánh chí tôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Kìa chúng dân muôn nước đổ về
	    mà phủ phục nơi tôn nhan Chúa,
	    Vì chúng nhìn nhận Ngài phán quyết chí công.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
