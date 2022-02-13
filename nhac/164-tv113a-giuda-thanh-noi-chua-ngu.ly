% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Giu-đa Thành Nơi Chúa Ngự" }
  composer = "Tv. 113A"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 \tuplet 3/2 { e8 a g } |
  g g f e |
  d4 \slashedGrace { d16 ( } \tuplet 3/2 { e8) c e } |
  f d a' fs |
  g4 r8 e16 a |
  a8. c16 \tuplet 3/2 { a8 c d } |
  bf4 r8 c16 a |
  g8. g16 \tuplet 3/2 { a8 f d } |
  c2 \bar "||"
  
  e8 e r d16 (e) |
  c8 c f4 |
  r8 g g g ~ |
  g a f e |
  d2 ~ |
  d4 r8 e |
  c c a'4 ~ |
  a8 a4 c8 |
  g4 r8 g |
  e' d d4 ~ |
  d8 bf4 bf8 |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*8
  e8 e r d16 (e) |
  c8 c f4 |
  r8 e e e ~ |
  e f d c |
  bf2 ~ |
  bf4 r8 c |
  a a f'4 ~ |
  f8 f4 f8 |
  e4 r8 e |
  g g fs4 ~ |
  fs8 g4 g8 |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Hồi Ít -- ra -- en ra khỏi Ai Cập,
      thuở nhà Gia -- cóp rời đất ngoại bang,
      thì Giu -- đa trở thành nơi Chúa ngự,
      Ít -- ra -- en nên lãnh địa của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Vì cớ chi Gio -- đan chảy ngược dòng,
	    biển vì đâu đã vội vã chạy lui,
	    đồi nương sao nhảy chồm như lũ cừu,
	    Núi non sao nô nức như chiên vậy?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Kìa đất lung lay trước tôn nhan Ngài,
	    Chúa nhà Gia -- cóp, Thượng Đế càn khôn,
	    Ngài đã biến đá tảng nên vũng hồ,
	    Đá sỏi nay nên suối chảy dạt dào.
    }
  >>
  \set stanza = "ĐK:"
  Thấy thế, biển liền chạy trốn,
  sông Gio -- đan cũng chảy ngược dòng,
  Núi đồi nhảy nhót như lũ cừu,
  Gò nỗng tung tăng tựa đàn chiên.
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
    \override LyricHyphen.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
