% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Như Nai Rừng Mong Mỏi" }
  composer = "Tv. 41"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8 g f g |
  ef4. c8 |
  d4 bf'8 bf |
  a4 r8 a |
  bf bf4 b!8 |
  c4. a8 |
  c c4 cs8 |
  d2 \bar "||" \break
  
  g,8 g a a |
  bf4 a8 (g) |
  fs4. d8 |
  bf' (a) g g |
  d'2 |
  c8. bf16 c8 d |
  g,8. ([bf16 a8]) g |
  d4. d8 |
  a'8. ([bf16 a8]) g |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 g f g |
  ef4. c8 |
  d4 g8 g |
  d4 r8 d |
  g g4 f8 |
  ef4. d8 |
  a' a4 e!8 |
  fs2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Như nai rừng mong mỏi,
  tìm về suối nước trong,
  Hồn con đây
  <<
    { thao thức }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \override Lyrics.LyricText.font-shape = #'italic
	    rạo rực
	}
  >>
  tìm tôn nhan Thiên Chúa
  <<
    {
      \set stanza = "1."
      Này hồn con khao khát Chúa Trời
      là Chúa Trời hằng sống
      Bao giờ con mới được đi về bệ kiến Tôn Nhan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lệ sầu như cơm bữa đêm ngày
	    vì ngưỡng vọng về Chúa
	    Bao thù nhân cứ hỏi con hoài: này Chúa ngươi đâu?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hoài vọng miên man tới thuở nào
	    cùng tiến về nhà Chúa
	    Theo đoàn dân hớn hở lên đền rập tiếng tung hô.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này hồn tôi sao mãi u sầu,
	    hãy tín nhiệm vào Chúa
	    Tôi còn luôn tán tụng Danh Ngài là Chúa Trời tôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Kìa vực sâu vang tiếng kêu gào,
	    dòng thác Ngài đổ xuống
	    Bao là cơn sóng cả tuôn trào vùi lấp thân con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngày ngày muôn ân phúc cao dầy
	    Ngài đoái tình gửi tới
	    Đêm về con tấu nhạc ca mừng nguồn phúc sinh con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Ngài đành tâm quên lãng con hoài,
	    lạy Chúa nguồn trợ giúp
	    Sao để con cứ bị quân thù đàn áp khôn ngơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này mình con xương cốt rã rời
	    vì quân thù đàn áp
	    Đêm ngày qua chúng hỏi con hoài:
	    này Chúa ngươi đâu?
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
    \override Lyrics.LyricSpace.minimum-distance = #0.45
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
