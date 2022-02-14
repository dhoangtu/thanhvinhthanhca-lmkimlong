% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Ban Chiến Thắng" }
  composer = "Tv. 19"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 g8. a16 |
  a8 fs fs4 ~ |
  fs8 e d b' |
  b4 b8 c |
  a c d4 ~ |
  d8 b c a |
  g2 |
  g4 a8 fs |
  e8. d16 b'8 c |
  a4 a8. a16 |
  d8 d4 b8 |
  c4 a8 b |
  g4 r8 \bar "||" \break
  
  g8 |
  a4 a8 b |
  d,2 |
  d'8. d16 b8 c |
  c4. b8 |
  g4 c8 b |
  a2 |
  fs8. a16 g8 e |
  \slashedGrace { d16 (e } d4.) a'8 |
  a fs4 g8 |
  a4 a8 a |
  d8. d16 c8 a |
  g2 \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*11
  r4.
  g8 |
  a4 a8 b |
  d,2 |
  b'8. b16 g8 a |
  a4. g8 |
  e4 a8 g |
  fs2 |
  fs8. a16 g8 e |
  \slashedGrace { d16 (e } d4.) cs8 |
  cs d4 e8 |
  fs4 e8 e |
  fs8. fs16 fs8 fs |
  g2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin Chúa đáp lời ngài trong ngày quẫn bách,
      Danh Chúa nhà Gia -- cop thương đoái hộ phù.
      Xin tiếp viện ngài từ nơi thánh điện,
      Và từ Si -- on xin Chúa nâng đỡ ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin Chúa nhớ phẩm vật xưa ngài kính tiến,
	    Hy lễ toàn thiêu đó xin Chúa vui nhận.
	    Xin Chúa cho ngài được như ước nguyện,
	    điều ngài tính toán xin Chúa cho liễu thành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xe chiến với ngựa trận bao người tín thác
	    nhưng chúng đều xiêu té,
	    đâu ích chi nào.
	    Đây chúng con kêu cầu danh Chúa thôi,
	    hào hùng chiến thắng xin phất cao lá cờ.
    }
  >>
  \set stanza = "ĐK:"
  Giờ đây tôi biết rằng Chúa đã ban chiến thắng
  cho người Chúa phong vương,
  Từ thánh cung cao thẳm Chúa đáp lời
  ra tay thực hiện những chiến công uy hùng.
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
